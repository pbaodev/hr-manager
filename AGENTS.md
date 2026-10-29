# AGENTS.md

Hướng dẫn cho AI agent (Claude Code, Codex, Cursor…) làm việc trong repo. Repo do một người giữ; agent hỗ trợ nhưng
không quyết định thay. Trang này chỉ ra cần đọc gì trước khi làm và những luật luôn áp dụng; nội dung chi tiết nằm ở
các file được dẫn tới.

## Read first

| Task | Read |
|---|---|
| Mọi task | Task và Feature trên tracker; mục liên quan và Boundaries trong [SPEC](docs/SPEC.md); [project.md](docs/project.md); [setup](docs/setup.md) khi chưa chạy được dự án |
| Sửa code | Modules và Traceability trong SPEC; tài liệu liên quan trong `docs/design/`; [conventions](docs/conventions/README.md); ADR liên quan trong [decisions](docs/decisions/README.md) |
| Đụng luật nghiệp vụ hoặc dữ liệu | [domain.md](docs/domain.md), [data design](docs/design/data.md) |
| Đụng API hoặc contract | [API design](docs/design/api.md), `contracts/openapi.yaml` |
| Đụng giao diện | [UI flow](docs/ui-flow.md), [UI design](docs/design/ui.md) |
| Viết hoặc sửa test | Test strategy và Traceability trong SPEC; [testing](docs/testing.md) |
| Deploy, phát hành hoặc sự cố | [runbook](docs/runbook.md), mục Releases trong [git-workflow.md](docs/playbook/git-workflow.md) |
| Đụng prompt, model hoặc tính năng AI | [AI component](docs/design/ai.md), [AI components guide](docs/playbook/ai-components.md) |
| Phân tích yêu cầu | [analysis guide](docs/playbook/analysis.md), [requirements](docs/requirements.md), [stories](docs/stories.md), [domain](docs/domain.md) |
| Thiết kế | [design guide](docs/playbook/design.md), [ARCHITECTURE.md](ARCHITECTURE.md), [decisions](docs/decisions/README.md) |
| Viết hoặc sửa tài liệu | [documents.md](docs/playbook/documents.md) |
| Đổi hành vi đã chốt | [change-control.md](docs/playbook/change-control.md) |

`docs/playbook/` là hướng dẫn của template; mọi file khác trong `docs/`, cùng `ARCHITECTURE.md`, là tài liệu của dự
án. Chỉ tài liệu có Status `Accepted` là đã chốt. Mục còn trống, dòng in nghiêng và tài liệu `Draft` hoặc `Proposed`
chưa phải quyết định.

## Role of the agent

Người giữ cả bốn mũ trong [hats.md](docs/playbook/hats.md); agent hỗ trợ theo bảng AI by hat ở đó.

- **Analysis:** gợi câu hỏi, edge case và chỗ mơ hồ. Luật nghiệp vụ agent đề xuất ghi Status `Assumed`, không ghi
  `Confirmed`.
- **Design:** đưa phương án và trade-off theo quality attribute; không tự chọn stack hay thêm dịch vụ.
- **Code:** làm trong phạm vi task, theo SPEC và tài liệu thiết kế.
- **Review:** khi được nhờ phản biện, chỉ ra vấn đề cụ thể kèm vị trí và mã liên quan; không khen chung chung.

## Commands

Lệnh của dự án nằm ở mục Commands trong [SPEC](docs/SPEC.md#commands). Khi chưa cấu hình, `make setup` và `make check`
in thông báo "chưa được cấu hình" và trả lỗi. Lúc đó repo chưa có lệnh nào kiểm được ứng dụng.

## Tasks

Feature, Task, Bug, Spike và CR nằm trên tracker ghi ở mục Tools của [project.md](docs/project.md); default là GitHub
Issues kèm board GitHub Projects. Việc chỉ nằm ở tracker: không tạo `tasks/todo.md` hay danh sách việc khác trong repo.
Chỉ nhận Issue ở cột `Ready`. PR ghi `Closes #123` để task tự đóng khi merge; PR trung gian của Issue tài liệu ghi
`Refs #123`. Tạo Issue thì gắn label `type:*` và `priority:*` theo
[working-agreement.md](docs/playbook/working-agreement.md).

## Rules

- Chỉ sửa trong phạm vi task. Cần sửa ngoài phạm vi thì hỏi trước.
- Code, SPEC và tài liệu thiết kế nói khác nhau thì dừng phần bị ảnh hưởng và hỏi. Không tự chọn một bên, không sửa
  tài liệu `Accepted` cho khớp với code.
- Không ghi framework, DB hay dịch vụ dùng để xây hệ thống vào `requirements.md`, `stories.md` và `domain.md`.
- Đổi API thì sửa contract; đổi màn hình, operation hay dữ liệu của một story thì sửa dòng của story đó trong
  Traceability. Làm trong cùng PR.
- Làm theo Boundaries trong SPEC: việc ở mục Ask first thì hỏi trước, việc ở mục Never thì không làm.
- Nhánh, commit và PR theo [git-workflow.md](docs/playbook/git-workflow.md); mỗi task một PR. Không push hay
  merge khi chưa được yêu cầu, không push thẳng `main`, không force-push, không dùng `--no-verify`.
- Không thêm thư viện hay dịch vụ khi chưa được đồng ý; thư viện ảnh hưởng tới kiến trúc cần ADR.
- Không hạ ngưỡng test, eval hay quality attribute để công việc được coi là xong.
- Không đưa secret hay dữ liệu thật của người dùng vào code, test, log, prompt mẫu, smoke set hay PR.

## Using agent-skills

Skill của agent-skills có nơi lưu mặc định riêng. Trong repo này, theo cột bên phải.

| Skill | Default của skill | Trong repo này |
|---|---|---|
| `/spec` | `SPEC.md` theo cấu trúc của skill | Story vào [stories](docs/stories.md); actor và quality attribute vào [requirements](docs/requirements.md); luật vào [domain](docs/domain.md); module và traceability vào [docs/SPEC.md](docs/SPEC.md), theo mẫu sẵn có |
| `/plan` | `tasks/plan.md`, `tasks/todo.md` | Issue Feature và Task trên tracker. Quyết định ghi ADR, câu hỏi ghi `questions.md`, thứ tự theo milestone |
| `/build` | Lấy task kế tiếp trong `tasks/todo.md` | Làm task được giao, hoặc Task ở cột `Ready` trên tracker |
| `/review` | Theo skill | Sửa hết phát hiện mức Critical và Required trước khi merge, theo [git-workflow.md](docs/playbook/git-workflow.md) |
| `/ship` | Checklist của skill | Release gate ở Phase 4 trong [phases.md](docs/playbook/phases.md) và mục Releases trong git-workflow |
| `/constraints` | `CONSTRAINTS.md` | Boundaries trong SPEC, quality attribute trong requirements, quy tắc code trong `docs/conventions/` |
| API and interface design | Theo skill | Kết quả ghi vào [API design](docs/design/api.md) và file contract |
| Git workflow | Nhánh `feature/<desc>`, không squash | Nhánh `<type>/<issue>-<desc>`, squash merge, theo [git-workflow.md](docs/playbook/git-workflow.md) |
| ADR | `docs/decisions/` | Theo [_template.md](docs/decisions/_template.md), thêm một dòng vào [index](docs/decisions/README.md) |

## Reporting

Khi báo kết quả hoặc viết PR, ghi đã đổi gì, đã chạy lệnh gì ở môi trường nào (local, CI, staging), kết quả ra sao và
phần nào chưa kiểm. Đọc code hay đọc thiết kế không phải bằng chứng là code đã chạy đúng.
