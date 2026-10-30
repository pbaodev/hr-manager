#!/usr/bin/env bash
# Dựng GitHub cho repo tạo từ template, ở Phase 0.
#
# Yêu cầu: gh CLI đã đăng nhập (gh auth login); repo đã push lên GitHub và có nhánh main.
# Cách dùng:
#   scripts/bootstrap-github.sh              # labels và cài đặt merge
#   scripts/bootstrap-github.sh --protect    # thêm: branch protection cho main
#   scripts/bootstrap-github.sh --baseline   # thêm: milestone Baseline và một Issue cho mỗi deliverable Phase 0–3
# Chạy lại nhiều lần được: label được cập nhật; milestone và Issue đã có (theo tiêu đề) thì bỏ qua.
# Board GitHub Projects tạo tay, xem Phase 0 trong docs/playbook/phases.md.
set -euo pipefail

WITH_PROTECT=false
WITH_BASELINE=false
for arg in "$@"; do
  case "$arg" in
    --protect) WITH_PROTECT=true ;;
    --baseline) WITH_BASELINE=true ;;
    *) echo "Tham số không hợp lệ: $arg" >&2; exit 1 ;;
  esac
done

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Repo: $REPO"

# 1. Labels: tên|màu|mô tả. Mẫu Issue trong .github/ISSUE_TEMPLATE/ dùng các label type:*.
LABELS=(
  "type:feature|1d76db|Một hoặc vài user story; chạy Feature loop"
  "type:task|5319e7|Việc vừa một PR"
  "type:bug|d73a4a|Hành vi khác với tài liệu hoặc kết quả mong đợi"
  "type:spike|0e8a16|Thử nhanh để trả lời một câu hỏi, có time box"
  "type:change-request|fbca04|Đổi hành vi, interface, kiến trúc hoặc phạm vi đã chốt"
  "priority:must|b60205|Thiếu thì bản phát hành vô nghĩa"
  "priority:should|d93f0b|Nên có"
  "priority:could|fef2c0|Có thì tốt"
)
for row in "${LABELS[@]}"; do
  IFS='|' read -r name color desc <<<"$row"
  gh label create "$name" --repo "$REPO" --color "$color" --description "$desc" --force >/dev/null
done
echo "✓ Labels"

# 2. Merge: chỉ squash merge, commit lấy theo tiêu đề PR, tự xóa nhánh sau merge.
gh repo edit "$REPO" \
  --enable-squash-merge --squash-merge-commit-message pr-title \
  --enable-merge-commit=false --enable-rebase-merge=false \
  --delete-branch-on-merge >/dev/null
echo "✓ Merge settings"

# 3. Branch protection cho main. Cần quyền admin; repo private cần gói GitHub Pro hoặc Team trở lên.
#    Bắt buộc qua PR và các check dưới; không yêu cầu người duyệt vì GitHub không cho tự duyệt PR của mình.
#    contexts phải khớp tên job trong .github/workflows/; thêm hoặc bỏ job thì sửa ở đây và chạy lại.
if $WITH_PROTECT; then
  gh api -X PUT "repos/$REPO/branches/main/protection" --input - >/dev/null <<'JSON'
{
  "required_status_checks": { "strict": true, "contexts": ["docs", "contract", "pr-title"] },
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0 },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON
  echo "✓ Branch protection (main)"
fi

# 4. Milestone Baseline và Issue cho deliverable Phase 0–3, để theo dõi baseline trên board.
#    Danh sách theo cột Product trong bảng Project types (docs/playbook/README.md). Xóa dòng không áp dụng
#    trước khi chạy, hoặc đóng Issue đó kèm lý do.
if $WITH_BASELINE; then
  MILESTONE="Baseline"
  if ! gh api "repos/$REPO/milestones?state=all&per_page=100" --jq '.[].title' | grep -Fxq "$MILESTONE"; then
    gh api "repos/$REPO/milestones" -f title="$MILESTONE" \
      -f description="Phase 0–3: requirements, domain và thiết kế đã Accepted." >/dev/null
  fi

  # Tiêu đề|phase|file hoặc kết quả
  DELIVERABLES=(
    "Project setup|0 Setup|docs/project/project.md, board, branch protection"
    "Brief và quyết định Go/Pivot/Stop|1 Discovery|docs/project/brief.md, docs/project/questions.md"
    "Requirements: actor, phân quyền, use case, quality attribute|2 Analysis|docs/analysis/requirements.md"
    "User stories và acceptance criteria|2 Analysis|docs/analysis/stories.md"
    "Domain: glossary, entity, vòng đời, luật, edge case|2 Analysis|docs/analysis/domain.md"
    "UI flow|2 Analysis|docs/analysis/ui-flow.md"
    "ADR: architecture style, stack, lưu trữ dữ liệu, auth, hosting|3 Design|docs/decisions/"
    "Architecture: Context, Container, drivers, cross-cutting|3 Design|ARCHITECTURE.md"
    "Data design và migration đầu tiên|3 Design|docs/design/data.md"
    "API design và contract|3 Design|docs/design/api.md, contracts/openapi.yaml"
    "Components và flows|3 Design|docs/design/components.md, docs/design/flows.md"
    "UI design|3 Design|docs/design/ui.md"
    "SPEC v1.0 và conventions|3 Design|docs/build/SPEC.md, docs/build/conventions/"
    "Setup, make check, CI và staging|3 Design|Makefile, .github/workflows/, docs/build/setup.md"
  )
  existing_titles=$(gh issue list --repo "$REPO" --state all --limit 1000 --json title --jq '.[].title')
  for row in "${DELIVERABLES[@]}"; do
    IFS='|' read -r title phase output <<<"$row"
    full_title="[Baseline] $title"
    if grep -Fxq "$full_title" <<<"$existing_titles"; then
      continue
    fi
    gh issue create --repo "$REPO" --title "$full_title" --label "type:task" --milestone "$MILESTONE" \
      --body "$(printf '**Phase:** %s\n\n**Output:** %s\n\n**Done when:** đạt Exit criteria của phase trong docs/playbook/phases.md; tài liệu có Status `Accepted` và dòng Reviewed đã điền.\n\nTài liệu có thể merge qua nhiều PR: PR trung gian ghi `Refs #số-issue`, PR cuối ghi `Closes #số-issue`.' "$phase" "$output")" \
      >/dev/null
  done
  echo "✓ Milestone Baseline và Issue deliverable"
fi

echo "Xong. Việc còn lại: tạo board GitHub Projects với các cột Todo, Ready, In progress, In review, Done."
