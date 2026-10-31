# Documentation index

Mỗi thông tin có một nơi chính; nơi khác cần thì dẫn link hoặc mã, không chép lại. Chỉ tài liệu `Accepted` là đã chốt.
Cột Hat là mũ phụ trách tài liệu, theo [hats](playbook/hats.md). Cột Status chép từ header của từng file; header là nơi
chính. PR đổi Status của một tài liệu thì sửa dòng tương ứng ở đây trong cùng PR.

```text
docs/
  project/      Phase 0–1: dự án, bài toán, nghiên cứu, câu hỏi
  analysis/     Phase 2: yêu cầu, story, luật nghiệp vụ, màn hình
  design/       Phase 3: component, dữ liệu, API, luồng, giao diện
  decisions/    Phase 1 trở đi: ADR
  build/        Phase 3–4: SPEC, setup, testing, conventions
  operations/   Phase 5: runbook; user guide và handover khi cần
  playbook/     Hướng dẫn quy trình của template, không phải tài liệu dự án
```

## Project

| Document | Answers | Hat | Phase | Status |
|---|---|---|---|---|
| [project.md](project/project.md) | Mục tiêu, quỹ thời gian, công cụ, chỗ làm khác default | Ops | 0 | Accepted |
| [brief.md](project/brief.md) | Bài toán, giải pháp ba lớp và ba tính năng AI, phạm vi, rủi ro; có nên làm không | Analyst | 1 | Accepted |
| [research.md](project/research.md) | Phân rã chức năng, văn bản luật, nguồn tham khảo | Analyst | 1 | Accepted |
| [questions.md](project/questions.md) | Câu hỏi chờ công ty trả lời và assumption đang dùng | Analyst | 1 trở đi | Cập nhật liên tục |

## Analysis

| Document | Answers | Hat | Phase | Status |
|---|---|---|---|---|
| [requirements.md](analysis/requirements.md) | Ai dùng, được làm gì, use case, quality attribute | Analyst | 2 | Accepted |
| [stories.md](analysis/stories.md) | User story của M1–M6, acceptance criteria, priority | Analyst | 2 | Accepted |
| [invest.md](analysis/invest.md) | Story MVP đạt INVEST tới đâu | Analyst | 2 | Draft |
| [domain.md](analysis/domain.md) | Thuật ngữ, entity, vòng đời, luật nghiệp vụ, edge case, dữ liệu nhạy cảm | Analyst | 2 | Accepted |
| [ui-flow.md](analysis/ui-flow.md) | Người dùng thấy và làm gì trên từng màn hình | Analyst | 2 | Accepted |

## Design

| Document | Answers | Hat | Phase | Status |
|---|---|---|---|---|
| [ARCHITECTURE.md](../ARCHITECTURE.md) | C4 Context và Container, driver, cross-cutting, threat, deployment | Architect | 3 | Mẫu, điền ở Phase 3 |
| [components.md](design/components.md) | C4 Component: module, dependency rule, frontend, cấu hình | Architect | 3 | Mẫu, điền ở Phase 3 |
| [data.md](design/data.md) | Dữ liệu lưu thế nào, luật nào giữ ở tầng dữ liệu, transaction, migration | Architect | 3 | Mẫu, điền ở Phase 3 |
| [api.md](design/api.md) | Quy ước API, lỗi, xác thực, danh sách operation | Architect | 3 | Mẫu, điền ở Phase 3 |
| [openapi.yaml](../contracts/openapi.yaml) | Contract chính xác của API | Architect | 3 | Mẫu, điền ở Phase 3 |
| [flows.md](design/flows.md) | Sequence diagram của luồng chính và job | Architect | 3 | Mẫu, điền ở Phase 3 |
| [ui.md](design/ui.md) | Design system, trạng thái màn hình, định dạng, accessibility | Architect | 3 | Mẫu, điền ở Phase 3 |
| [ai.md](design/ai.md) | Component AI của ba tính năng ở M6 | Architect | 3 | Mẫu, điền ở Phase 3 |
| [decisions/](decisions/README.md) | Vì sao chọn phương án này, đã cân nhắc phương án nào | Architect | 1 trở đi | Chưa có ADR; ADR-0001 tới 0006 đã bỏ |

## Build

| Document | Answers | Hat | Phase | Status |
|---|---|---|---|---|
| [SPEC.md](build/SPEC.md) | Module, traceability, lệnh, boundaries; tài liệu chính khi làm task | Architect | 3 | Mẫu, điền ở Issue #13 |
| [conventions/](build/conventions/README.md) | Quy tắc code máy không tự kiểm được | Architect | 3 trở đi | Mẫu, điền ở Issue #13 |
| [setup.md](build/setup.md) | Chạy dự án trên máy sạch | Ops | 3 | Mẫu, điền ở Issue #14 |
| [testing.md](build/testing.md) | Ca thử tay, mức lỗi, kết quả test mỗi bản phát hành | Developer | 3 trở đi | Mẫu |
| [CHANGELOG.md](../CHANGELOG.md) | Mỗi bản phát hành đổi gì cho người dùng | Ops | 4 | Mẫu |

## Operations

| Document | Answers | Hat | Phase | Status |
|---|---|---|---|---|
| [runbook.md](operations/runbook.md) | Deploy, rollback, khôi phục, xử lý sự cố | Ops | 5 | Mẫu |
| `operations/user-guide.md` | Người dùng cuối làm từng việc thế nào; tạo khi có người dùng khác | Analyst | 5 | Chưa tạo |

## Work items and guides

| Document | Answers | Hat |
|---|---|---|
| [Feature](../.github/ISSUE_TEMPLATE/feature.md), [Task](../.github/ISSUE_TEMPLATE/task.md), [Bug](../.github/ISSUE_TEMPLATE/bug.md), [Spike](../.github/ISSUE_TEMPLATE/spike.md), [CR](../.github/ISSUE_TEMPLATE/change_request.md), [PR](../.github/PULL_REQUEST_TEMPLATE.md) | Mẫu công việc, thay đổi và bằng chứng | Developer |
| [AGENTS.md](../AGENTS.md) | Agent đọc gì trước khi làm từng loại việc, luật luôn áp dụng | — |
| [playbook](playbook/README.md) | Quy trình sáu phase, bốn mũ, kỹ thuật phân tích và thiết kế, git workflow | — |
