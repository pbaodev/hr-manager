# SPEC: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Version:** [v1.0]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](requirements.md) · [stories](stories.md) · [ARCHITECTURE](../ARCHITECTURE.md) ·
  [components](design/components.md) · [testing](testing.md)

> SPEC là tài liệu chính khi làm task: người và agent đọc mục liên quan trước khi sửa code. SPEC nối yêu cầu với thiết
> kế và code: module nào làm gì, mỗi yêu cầu được thiết kế ở đâu, hiện thực ở đâu và kiểm bằng gì. Hành vi nằm ở
> stories, requirements và domain; thiết kế nằm ở ARCHITECTURE và `design/`; lý do nằm ở ADR. Sau khi `Accepted`, thay
> đổi đi theo [change-control.md](playbook/change-control.md) và được ghi vào Changelog. Dòng in nghiêng là ví dụ, xóa
> khi điền.

## Overview

[Hệ thống làm gì, 2–3 câu. Sơ đồ nằm ở ARCHITECTURE.md.]

## Modules

Cấu trúc và dependency rule nằm ở [components](design/components.md).

| Module | Responsibility | Path | Container | Depends on |
|---|---|---|---|---|
| *booking* | *Đặt, hủy lịch; giữ BR-001 tới BR-004* | *`src/booking/`* | *api* | *rooms* |
| *calendar_sync* | *Đồng bộ lịch đặt sang Google Calendar* | *`src/calendar_sync/`* | *worker* | *booking* |

## Interfaces

Ghi nơi lưu contract thay vì chép lại nội dung. Quy ước chung nằm ở [api](design/api.md).

| Interface | Provider → Consumer | Contract |
|---|---|---|
| *HTTP API* | *api → web* | *`contracts/openapi.yaml`* |
| *Job `sync_calendar`* | *api → worker* | *`src/calendar_sync/jobs.py`* |

## Traceability

Mỗi story `Must` và mỗi architecture driver có một dòng. Bảng này tổng hợp liên kết; nguồn của từng liên kết nằm ở
tài liệu tương ứng: màn hình ở [UI flow](ui-flow.md), operation ở [api](design/api.md), luật giữ ở tầng dữ liệu ở
[data](design/data.md). Hai nơi nói khác nhau thì sửa nguồn trước, rồi sửa bảng. Dòng có link tới test chưa có nghĩa
là test đó đã chạy trên bản hiện tại; Status mới nói điều đó.

| Requirement | Screens | API | Data | Modules | Automated tests | Manual tests | Status |
|---|---|---|---|---|---|---|---|
| *US-001* | *SCR-001, SCR-002* | *`createBooking`* | *`booking`; exclusion constraint* | *booking, rooms* | *`tests/booking/test_create.py`; E2E `book-room`* | *TC-001* | *Tested* |
| *QA-002* | *—* | *`createBooking`* | *Exclusion constraint; ADR-0004* | *booking* | *`tests/booking/test_concurrent_create.py`* | *—* | *Implemented* |

**Status:** `Designed` (Phase 3 hoặc Design delta) → `Implemented` (code đã merge, theo Definition of Done của story)
→ `Tested` (test liên quan pass trên staging khi đóng milestone) → `Accepted` (đã nghiệm thu; Client delivery: bên
nhận đã xác nhận). Mốc chuyển trạng thái nằm ở [phases.md](playbook/phases.md). Cập nhật Status và cột test là việc
thường ngày, không cần CR hay tăng version của SPEC.

## Commands

| Purpose | Command |
|---|---|
| Setup | `make setup`; lần đầu theo [setup](setup.md) |
| Lint, type check, test | `make check` |
| Chạy local | [lệnh] |
| E2E | [lệnh] |
| Lint contract | `npx @redocly/cli@1 lint contracts/openapi.yaml` |
| Eval-lite, khi có tính năng AI | [lệnh] |

## Test strategy

- **Unit:** [phạm vi. Domain logic và business rule test không cần DB; dịch vụ ngoài và LLM được mock]
- **Integration:** [DB thật, migration, constraint; chạy ở đâu]
- **Contract:** [cách kiểm API khớp với contract]
- **E2E:** [luồng chính chạy trên staging]
- **Manual:** ca không tự động hóa được và ca nghiệm thu, ghi ở [testing](testing.md)
- **Eval-lite:** [khi có tính năng AI, theo [ai](design/ai.md)]

## Boundaries

Default cho cả người và agent; sửa theo dự án.

- **Always:** làm trong phạm vi task; đọc mục SPEC và tài liệu thiết kế liên quan trước khi sửa; viết test cho hành vi
  mới; chạy `make check` trước khi mở PR; ghi rõ đã kiểm gì và chưa kiểm gì.
- **Ask first:** thêm dependency hoặc dịch vụ; đổi contract, schema hoặc migration; đổi dependency rule giữa các module;
  đổi prompt hoặc model; sửa file trong mục Protected files; code cần làm khác tài liệu thiết kế.
- **Never:** commit secret hoặc dữ liệu thật của người dùng; sửa tài liệu `Accepted` cho khớp code mà không báo; hạ
  ngưỡng test, eval hay quality attribute; push thẳng `main`, force-push hoặc dùng `--no-verify`.

## Protected files

| Path | Rule |
|---|---|
| *`migrations/`* | *Một migration mỗi PR; không sửa migration đã chạy trên production* |
| *`contracts/`* | *Thay đổi không tương thích đi theo change-control loại Interface* |

## Changelog

| Version | Date | Change | CR |
|---|---|---|---|
| *v1.0* | *[YYYY-MM-DD]* | *Bản đầu, chốt cuối Phase 3* | *—* |
