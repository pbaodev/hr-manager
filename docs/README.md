# Documentation index

Mỗi thông tin có một nơi chính; nơi khác cần thì dẫn link hoặc mã, không chép lại. Chỉ tài liệu `Accepted` là đã chốt.
Cột Status ghi trạng thái ngày 2026-10-30; trạng thái chính xác nằm ở header của từng file.

```text
docs/
  project/      Phase 0–1: dự án, bài toán, nghiên cứu, câu hỏi
  analysis/     Phase 2: yêu cầu, story, luật nghiệp vụ, màn hình
  design/       Phase 3: component, dữ liệu, API, luồng, giao diện
  decisions/    Phase 1 trở đi: ADR
  build/        Phase 3–4: SPEC, setup, testing, conventions
  operations/   Phase 5: runbook
  assets/       Ảnh dùng trong tài liệu
  playbook/     Hướng dẫn quy trình của template, không phải tài liệu dự án
```

## Project

| Document | Answers | Phase | Status |
|---|---|---|---|
| [project.md](project/project.md) | Mục tiêu, quỹ thời gian, công cụ, chỗ làm khác default | 0 | Accepted |
| [brief.md](project/brief.md) | Bài toán, giải pháp, phạm vi, rủi ro; có nên làm không | 1 | Accepted |
| [research.md](project/research.md) | Phân rã chức năng, văn bản luật, nguồn tham khảo | 1 | Accepted |
| [questions.md](project/questions.md) | Câu hỏi chờ công ty trả lời và assumption đang dùng | 1 trở đi | Cập nhật liên tục |

## Analysis

| Document | Answers | Phase | Status |
|---|---|---|---|
| [requirements.md](analysis/requirements.md) | Ai dùng, được làm gì, use case, quality attribute | 2 | Accepted |
| [stories.md](analysis/stories.md) | 72 user story, acceptance criteria, phạm vi MVP | 2 | Accepted |
| [invest.md](analysis/invest.md) | Story MVP đạt INVEST tới đâu | 2 | Draft |
| [domain.md](analysis/domain.md) | Thuật ngữ, entity, vòng đời, luật nghiệp vụ, edge case, dữ liệu nhạy cảm | 2 | Accepted |
| [ui-flow.md](analysis/ui-flow.md) | Người dùng thấy và làm gì trên từng màn hình | 2 | Accepted |

## Design

| Document | Answers | Phase | Status |
|---|---|---|---|
| [ARCHITECTURE.md](../ARCHITECTURE.md) | C4 Context và Container, driver, cross-cutting, threat, deployment | 3 | Draft |
| [components.md](design/components.md) | C4 Component: module, dependency rule, frontend, cấu hình | 3 | Draft |
| [data.md](design/data.md) | Dữ liệu lưu thế nào, luật nào giữ ở tầng dữ liệu, transaction, migration | 3 | Draft |
| [schema.dbml](design/schema.dbml) | Schema dạng DBML, sinh từ data.md | 3 | Theo data.md |
| [api.md](design/api.md) | Quy ước API, lỗi, xác thực, danh sách operation | 3 | Draft |
| [openapi.yaml](../contracts/openapi.yaml) | Contract chính xác của API | 3 | Theo api.md |
| [flows.md](design/flows.md) | Sequence diagram của luồng chính và job | 3 | Draft |
| [ui.md](design/ui.md) | Design system, trạng thái màn hình, định dạng, accessibility | 3 | Draft |
| [ai.md](design/ai.md) | Component AI; điền khi làm M6 | 3 | Mẫu, chưa dùng |
| [decisions/](decisions/README.md) | Vì sao chọn phương án này, đã cân nhắc phương án nào | 1 trở đi | 6 ADR Accepted |

## Build

| Document | Answers | Phase | Status |
|---|---|---|---|
| [SPEC.md](build/SPEC.md) | Module, traceability, lệnh, boundaries; tài liệu chính khi làm task | 3 | Mẫu, điền ở Issue #13 |
| [conventions/](build/conventions/README.md) | Quy tắc code máy không tự kiểm được | 3 trở đi | Mẫu, điền ở Issue #13 |
| [setup.md](build/setup.md) | Chạy dự án trên máy sạch | 3 | Mẫu, điền ở Issue #14 |
| [testing.md](build/testing.md) | Ca thử tay, mức lỗi, kết quả test mỗi bản phát hành | 3 trở đi | Mẫu |
| [CHANGELOG.md](../CHANGELOG.md) | Mỗi bản phát hành đổi gì cho người dùng | 4 | Mẫu |

## Operations

| Document | Answers | Phase | Status |
|---|---|---|---|
| [runbook.md](operations/runbook.md) | Deploy, rollback, khôi phục, xử lý sự cố | 5 | Mẫu |

## Work items and guides

| Document | Answers |
|---|---|
| [Feature](../.github/ISSUE_TEMPLATE/feature.md), [Task](../.github/ISSUE_TEMPLATE/task.md), [Bug](../.github/ISSUE_TEMPLATE/bug.md), [Spike](../.github/ISSUE_TEMPLATE/spike.md), [CR](../.github/ISSUE_TEMPLATE/change_request.md), [PR](../.github/PULL_REQUEST_TEMPLATE.md) | Mẫu công việc, thay đổi và bằng chứng |
| [AGENTS.md](../AGENTS.md) | Agent đọc gì trước khi làm từng loại việc, luật luôn áp dụng |
| [playbook](playbook/README.md) | Quy trình sáu phase, bốn mũ, kỹ thuật phân tích và thiết kế, git workflow |
