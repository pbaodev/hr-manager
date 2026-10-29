# API design

- **Status:** Draft
- **Updated:** 2026-10-30
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](../requirements.md) · [SPEC](../SPEC.md) · [design guide](../playbook/design.md) ·
  [ARCHITECTURE](../../ARCHITECTURE.md) · ADR-0002, ADR-0004

> Contract là nguồn chính: [`contracts/openapi.yaml`](../../contracts/openapi.yaml). File này ghi quy ước chung, bảng mã
> lỗi và bản đồ từ user story tới operation. Phạm vi là MVP: các story có ✅ ở cột MVP trong
> [stories](../stories.md#summary). Operation của phần ngoài MVP thêm vào contract ở Feature loop.

## Style

- **Style:** REST trên HTTPS, JSON, theo modular monolith của ADR-0001.
- **Contract:** contract-first, theo lựa chọn của chủ dự án ngày 2026-10-30. Sửa `contracts/openapi.yaml` trước rồi mới
  sửa code. Frontend sinh type và client từ contract. Backend dùng model Pydantic viết tay; CI so schema FastAPI sinh ra
  với contract và báo lỗi khi lệch.
- **Compatibility:** CI so contract của PR với `main` để phát hiện breaking change. Breaking change là thay đổi loại
  Interface theo [change-control](../playbook/change-control.md) và tăng version chính. Hai bước kiểm này được thêm ở
  Issue #14.

## Operations

Cột Story trống là operation hạ tầng hoặc dùng chung. Mã lỗi ở cột Errors là mã có thể gặp ngoài lỗi chung `401`.

| Operation | Purpose | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|---|
| `POST /auth/login` | Đăng nhập bằng mã nhân viên | US-001 | Không cần đăng nhập | `200` | 401, 422, 423, 429; `invalid_credentials`, `account_throttled`, `rate_limited` |
| `POST /auth/refresh` | Đổi refresh token lấy cặp token mới (ADR-0004) | — | Người có cookie `refresh_token` hợp lệ | `204` | 401; `unauthenticated` |
| `POST /auth/logout` | Đăng xuất, thu hồi refresh token hiện tại | — | Mọi người đã đăng nhập | `204` | 401 |
| `GET /me` | Thông tin người đang đăng nhập, vai trò và cờ phải đổi mật khẩu | — | Mọi người đã đăng nhập | `200` | 401 |
| `POST /me/password` | Đổi mật khẩu của mình | US-001 | Mọi người đã đăng nhập | `204` | 401, 422; `invalid_credentials`, `password_too_short`, `password_reused` |
| `GET /accounts` | Danh sách tài khoản | US-002 | HR | `200` | 401, 403 |
| `POST /accounts` | Tạo tài khoản cho một nhân viên | US-002 | HR | `201` | 401, 403, 404, 409; `account_exists` |
| `POST /accounts/{accountId}/password-reset` | Đặt lại mật khẩu, trả mật khẩu tạm | US-002 | HR | `200` | 401, 403, 404 |
| `POST /accounts/{accountId}/lock` | Khóa tài khoản | US-002 | HR | `200` | 401, 403, 404, 409; `last_hr_account` |
| `POST /accounts/{accountId}/unlock` | Mở khóa tài khoản | US-002 | HR | `200` | 401, 403, 404, 409; `employee_terminated` |
| `PUT /accounts/{accountId}/hr-role` | Gán vai trò HR | US-003 | HR | `204` | 401, 403, 404 |
| `DELETE /accounts/{accountId}/hr-role` | Thu hồi vai trò HR | US-003 | HR | `204` | 401, 403, 404, 409; `last_hr_account` |
| `GET /positions` | Danh mục chức danh | US-005 | Mọi người đã đăng nhập | `200` | 401 |
| `POST /positions` | Thêm chức danh | US-005 | HR | `201` | 401, 403, 409, 422; `name_taken` |
| `PATCH /positions/{positionId}` | Đổi tên hoặc ngừng dùng chức danh | US-005 | HR | `200` | 401, 403, 404, 409, 422; `name_taken` |
| `GET /org-units/tree` | Cây tổ chức tại một ngày | US-009 | Mọi người đã đăng nhập; chỉ HR chọn được ngày khác hôm nay (US-010) | `200` | 401, 403 |
| `POST /org-units` | Tạo phòng ban | US-006 | HR | `201` | 401, 403, 409, 422; `org_unit_inactive`, `org_root_rule` |
| `POST /org-units/{orgUnitId}/changes` | Đổi tên hoặc chuyển phòng ban cha từ một ngày hiệu lực | US-006 | HR | `200` | 401, 403, 404, 409, 422; `org_cycle`, `org_root_rule`, `org_unit_inactive` |
| `GET /org-units/{orgUnitId}/heads` | Lịch sử trưởng phòng ban | US-008 | HR | `200` | 401, 403, 404 |
| `POST /org-units/{orgUnitId}/heads` | Bổ nhiệm trưởng phòng ban | US-008 | HR | `201` | 401, 403, 404, 409, 422; `head_overlap`, `head_not_employed` |
| `PATCH /head-assignments/{headAssignmentId}` | Thôi bổ nhiệm trưởng từ một ngày | US-008 | HR | `200` | 401, 403, 404, 422 |
| `GET /employees` | Tìm và lọc nhân viên | US-018, US-020 | HR thấy mọi người; Quản lý chỉ thấy phạm vi của mình (BR-013) | `200` | 401, 403, 404 |
| `POST /employees` | Tiếp nhận nhân viên mới cùng quá trình công tác và hợp đồng đầu tiên | UC-001, US-011 | HR | `201` | 401, 403, 409, 422; `national_id_taken`, `org_unit_inactive`, `contract_term_invalid` |
| `GET /employees/{employeeId}` | Chi tiết nhân viên | US-012, US-018 | HR; Quản lý với nhân viên trong phạm vi, chỉ phần công việc (BR-033) | `200` | 401, 404 |
| `PATCH /employees/{employeeId}` | Sửa thông tin cá nhân và liên hệ | US-012 | HR | `200` | 401, 403, 404, 409, 422; `version_conflict`, `national_id_taken` |
| `GET /employees/{employeeId}/assignments` | Quá trình công tác | US-013, US-018 | HR; Quản lý với nhân viên trong phạm vi | `200` | 401, 404 |
| `POST /employees/{employeeId}/assignments` | Ghi nhận thay đổi công tác có ngày hiệu lực | UC-002, US-013 | HR | `201` | 401, 403, 404, 409, 422; `effective_date_outside_employment`, `assignment_same_date`, `org_unit_inactive`, `reason_required` |
| `PUT /employees/{employeeId}/termination` | Ghi nhận nghỉ việc | UC-003, US-014 | HR | `200` | 401, 403, 404, 409, 422; `termination_before_hire`, `assignment_after_termination`, `last_hr_account` |
| `DELETE /employees/{employeeId}/termination` | Hủy ghi nhận nghỉ việc khi ngày làm việc cuối cùng chưa qua (BR-020) | — | HR | `204` | 401, 403, 404, 409; `termination_already_effective` |
| `GET /employees/{employeeId}/contracts` | Hợp đồng của nhân viên | US-015 | HR | `200` | 401, 403, 404 |
| `POST /employees/{employeeId}/contracts` | Thêm hợp đồng | US-015 | HR | `201` | 401, 403, 404, 409, 422; `contract_overlap`, `contract_term_invalid`, `contract_number_taken` |
| `PATCH /contracts/{contractId}` | Sửa hợp đồng | US-015 | HR | `200` | 401, 403, 404, 409, 422; `contract_overlap`, `contract_term_invalid`, `version_conflict` |
| `GET /contracts/expiring` | Hợp đồng sắp hết hạn | US-016 | HR | `200` | 401, 403 |
| `GET /me/profile` | Hồ sơ, quá trình công tác và hợp đồng của mình | US-017 | Mọi người đã đăng nhập | `200` | 401 |
| `PATCH /me/profile` | Sửa thông tin liên hệ của mình | US-017 | Mọi người đã đăng nhập | `200` | 401, 409, 422; `version_conflict` |
| `GET /leave-types` | Danh mục loại nghỉ | US-028 | Mọi người đã đăng nhập | `200` | 401 |
| `POST /leave-types` | Thêm loại nghỉ | US-028 | HR | `201` | 401, 403, 409, 422; `name_taken` |
| `PATCH /leave-types/{leaveTypeId}` | Sửa hoặc ngừng dùng loại nghỉ | US-028 | HR | `200` | 401, 403, 404, 409, 422; `name_taken`, `leave_type_annual_locked` |
| `GET /calendar-days` | Ngày nghỉ lễ và ngày làm bù của một năm | US-029 | Mọi người đã đăng nhập | `200` | 401 |
| `POST /calendar-days` | Khai báo ngày nghỉ lễ hoặc ngày làm bù | US-029 | HR | `201` | 401, 403, 409, 422; `calendar_day_conflict` |
| `DELETE /calendar-days/{day}` | Bỏ một ngày nghỉ lễ hoặc ngày làm bù | US-029 | HR | `200` | 401, 403, 404 |
| `GET /me/leave/balance` | Số dư và biến động phép của mình | US-022 | Mọi người đã đăng nhập | `200` | 401 |
| `GET /employees/{employeeId}/leave/balance` | Số dư phép của một nhân viên | US-027 | HR; Quản lý với nhân viên trong phạm vi | `200` | 401, 404 |
| `POST /employees/{employeeId}/leave/adjustments` | Điều chỉnh số dư phép kèm lý do | US-032 | HR | `201` | 401, 403, 404, 409, 422; `leave_insufficient_balance`, `reason_required` |
| `POST /leave-requests/preview` | Tính trước số ngày nghỉ và số phép còn lại, không lưu | UC-005 | Mọi người đã đăng nhập | `200` | 401, 409, 422; `leave_no_working_days`, `leave_overlap`, `leave_insufficient_balance`, `leave_exceeds_type_max`, `leave_outside_employment`, `leave_backdate_exceeded` |
| `GET /leave-requests` | Đơn nghỉ: của mình, đang chờ mình duyệt, hoặc của nhóm trong một khoảng ngày | US-024, US-025, US-027 | Mọi người với `scope=mine`; người duyệt với `scope=to-approve`; Quản lý và HR với `scope=team` | `200` | 401, 403 |
| `POST /leave-requests` | Gửi đơn nghỉ | UC-005, US-023 | Mọi người đã đăng nhập | `201` | 401, 409, 422; `leave_no_working_days`, `leave_overlap`, `leave_insufficient_balance`, `leave_exceeds_type_max`, `leave_outside_employment`, `leave_backdate_exceeded` |
| `GET /leave-requests/{leaveRequestId}` | Chi tiết đơn nghỉ | — | Người gửi, người duyệt, HR; Quản lý trong phạm vi thấy đơn nhưng không thấy lý do (BR-067) | `200` | 401, 404 |
| `POST /leave-requests/{leaveRequestId}/approve` | Duyệt đơn nghỉ | US-025, US-026 | Người duyệt của đơn; HR duyệt thay (BR-058) | `200` | 401, 404, 409; `invalid_state`, `self_approval`, `leave_insufficient_balance` |
| `POST /leave-requests/{leaveRequestId}/reject` | Từ chối đơn nghỉ kèm lý do | US-025, US-026 | Người duyệt của đơn; HR | `200` | 401, 404, 409, 422; `invalid_state`, `reason_required` |
| `POST /leave-requests/{leaveRequestId}/cancel` | Hủy đơn nghỉ | US-024 | Người gửi trước ngày bắt đầu; HR mọi lúc, kèm lý do (BR-061) | `200` | 401, 404, 409, 422; `invalid_state`, `leave_not_cancellable`, `reason_required` |
| `GET /notifications` | Thông báo của mình | US-034 | Mọi người đã đăng nhập | `200` | 401 |
| `POST /notifications/{notificationId}/read` | Đánh dấu đã đọc | — | Người nhận | `204` | 401, 404 |
| `POST /notifications/read-all` | Đánh dấu đã đọc tất cả | — | Mọi người đã đăng nhập | `204` | 401 |
| `GET /reports/overview` | Trang tổng quan | US-064 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403 |
| `GET /reports/headcount-movement` | Biến động nhân sự theo tháng | US-065 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |
| `GET /reports/headcount-movement/export` | Xuất báo cáo ra bảng tính | US-070 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |
| `GET /reports/leave-usage` | Số ngày nghỉ theo loại, phòng ban, nhân viên | US-067 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |
| `GET /reports/leave-usage/export` | Xuất báo cáo ra bảng tính | US-070 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |
| `GET /reports/leave-balances` | Số dư phép và phép tồn tại một ngày | US-067 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |
| `GET /reports/leave-balances/export` | Xuất báo cáo ra bảng tính | US-070 | HR; Quản lý với số liệu trong phạm vi (BR-127) | `200` | 401, 403, 404, 422 |

Story của MVP không có operation riêng:

- US-030, US-031: chạy bằng job `accrue-leave` và `roll-over-carryover` (ARCHITECTURE: Containers).
- US-034: thông báo được tạo trong cùng transaction với thao tác trên đơn; client đọc qua `GET /notifications`.
- US-070: mỗi báo cáo có operation `/export` đi kèm.

## Errors

- **Format:** RFC 9457 Problem Details, media type `application/problem+json`, gồm `type`, `title`, `status`, `detail`,
  thêm `code` ổn định, `rule` là mã luật nếu có, `errors` theo field khi `code` là `validation_failed`, và `traceId`.
  `detail` là câu tiếng Việt hiển thị được cho người dùng.
- **Mapping:** `422` khi bản thân request sai, dù dữ liệu hiện tại thế nào. `409` khi request đúng nhưng xung đột với
  dữ liệu hiện tại: trùng, chồng khoảng, sai trạng thái, hết phép. Lỗi không lường trước trả `500` với `traceId`,
  không lộ stack trace hay câu SQL.

| Code | HTTP | Meaning | Rule |
|---|---|---|---|
| `validation_failed` | 422 | Đầu vào sai kiểu hay định dạng; `errors` ghi lỗi theo từng field | — |
| `unauthenticated` | 401 | Chưa đăng nhập, token hết hạn hoặc đã bị thu hồi | ADR-0004 |
| `invalid_credentials` | 401 | Sai mã nhân viên hoặc mật khẩu; không nói rõ sai phần nào | BR-003, EC-015 |
| `account_throttled` | 423 | Tài khoản đang bị khóa tạm | BR-003 |
| `rate_limited` | 429 | Quá nhiều lần đăng nhập từ một IP | ARCHITECTURE: Threats |
| `password_change_required` | 403 | Phải đổi mật khẩu trước khi dùng chức năng khác | BR-002 |
| `forbidden` | 403 | Không đủ vai trò cho operation | Permission matrix |
| `not_found` | 404 | Không có tài nguyên, hoặc tài nguyên nằm ngoài phạm vi người xem | BR-013, BR-033 |
| `version_conflict` | 409 | Dữ liệu đã bị người khác sửa sau khi đọc | EC-016 |
| `invalid_state` | 409 | Thao tác không hợp lệ với trạng thái hiện tại | Lifecycles trong domain |
| `name_taken` | 409 | Tên danh mục đã tồn tại | BR-034, BR-040 |
| `account_exists` | 409 | Nhân viên đã có tài khoản | BR-001 |
| `last_hr_account` | 409 | Thao tác làm hệ thống không còn HR đang hoạt động | BR-004 |
| `employee_terminated` | 409 | Nhân viên đã nghỉ việc nên tài khoản không mở khóa được | BR-005 |
| `password_too_short` | 422 | Mật khẩu ngắn hơn `min_password_length` | BR-036 |
| `password_reused` | 422 | Mật khẩu mới trùng mật khẩu hiện tại | BR-036 |
| `org_cycle` | 409 | Phòng ban cha mới nằm trong nhánh con của chính nó | BR-008 |
| `org_root_rule` | 409 | Thao tác vi phạm luật phòng ban gốc | BR-007 |
| `org_unit_inactive` | 409 | Phòng ban không hoạt động trong khoảng thời gian liên quan | BR-014 |
| `head_overlap` | 409 | Phòng ban đã có trưởng trong khoảng thời gian đó | BR-011 |
| `head_not_employed` | 409 | Người được bổ nhiệm không làm việc trong suốt khoảng đó | BR-011 |
| `national_id_taken` | 409 | Số CCCD đã có ở hồ sơ khác; `detail` dẫn tới hồ sơ đó | BR-022, EC-018 |
| `effective_date_outside_employment` | 422 | Ngày hiệu lực ngoài khoảng làm việc | BR-017 |
| `assignment_same_date` | 409 | Đã có thay đổi công tác cùng ngày hiệu lực | EC-002 |
| `reason_required` | 422 | Thiếu lý do cho thao tác bắt buộc có lý do | BR-018, BR-059, BR-061 |
| `termination_before_hire` | 422 | Ngày làm việc cuối cùng trước ngày vào làm | EC-087 |
| `assignment_after_termination` | 409 | Còn thay đổi công tác có hiệu lực sau ngày làm việc cuối cùng | EC-009 |
| `termination_already_effective` | 409 | Ngày làm việc cuối cùng đã qua nên không hủy được | BR-020 |
| `contract_overlap` | 409 | Hợp đồng chồng thời gian với hợp đồng khác | BR-025, EC-014 |
| `contract_term_invalid` | 422 | Thời hạn hợp đồng vi phạm giới hạn của loại hợp đồng | BR-024, BR-028 |
| `contract_number_taken` | 409 | Số hợp đồng đã tồn tại | BR-037 |
| `leave_type_annual_locked` | 409 | Không ngừng dùng hay đổi chế độ của loại Phép năm | BR-041 |
| `calendar_day_conflict` | 409 | Ngày đã được khai báo | Aggregates trong domain: WorkCalendar |
| `leave_no_working_days` | 422 | Khoảng nghỉ không có ngày làm việc nào | BR-044, EC-025 |
| `leave_overlap` | 409 | Đơn chồng buổi với đơn khác đang chờ hoặc đã duyệt | BR-045 |
| `leave_insufficient_balance` | 409 | Không đủ phép năm tại thời điểm gửi hoặc duyệt | BR-053, EC-024 |
| `leave_exceeds_type_max` | 422 | Vượt số ngày tối đa mỗi đơn của loại nghỉ | BR-047 |
| `leave_outside_employment` | 422 | Ngày nghỉ ngoài khoảng làm việc | BR-046 |
| `leave_backdate_exceeded` | 422 | Ngày bắt đầu sớm hơn giới hạn gửi đơn cho ngày đã qua | BR-062 |
| `leave_not_cancellable` | 409 | Nhân viên hủy đơn đã duyệt khi đã tới ngày bắt đầu | BR-061 |
| `self_approval` | 409 | Người duyệt là chính người gửi | BR-060 |
| `internal_error` | 500 | Lỗi không lường trước; chỉ trả `traceId` | — |

**Status codes**

| HTTP | When |
|---|---|
| 200 | Đọc, sửa hoặc chuyển trạng thái thành công, trả tài nguyên sau thay đổi |
| 201 | Tạo thành công; kèm header `Location` |
| 204 | Thành công, không có body |
| 401 | Chưa đăng nhập, phiên hết hạn, hoặc sai thông tin đăng nhập |
| 403 | Đã đăng nhập nhưng không đủ vai trò, hoặc phải đổi mật khẩu trước |
| 404 | Không có tài nguyên, hoặc người gọi không được biết tài nguyên đó tồn tại |
| 409 | Xung đột với dữ liệu hiện tại |
| 422 | Đầu vào sai định dạng hoặc vi phạm luật về giá trị |
| 423 | Tài khoản đang bị khóa tạm |
| 429 | Quá giới hạn số lần đăng nhập |
| 500 | Lỗi không lường trước |

## Auth

- **Authentication:** theo ADR-0004.
  - `POST /auth/login` đặt hai cookie `HttpOnly`, `Secure`, `SameSite=Strict`: `access_token` là JWT 15 phút,
    `refresh_token` sống 12 giờ và chỉ gửi tới `/api/v1/auth/refresh`.
  - Client gặp `401 unauthenticated` thì gọi `POST /auth/refresh` một lần rồi thử lại; refresh lỗi thì về màn hình đăng
    nhập.
  - Request ghi dữ liệu phải có header `Origin` trùng domain của hệ thống.
- **Authorization:**
  - Mỗi request tải tài khoản, kiểm trạng thái và `token_version`, rồi tính vai trò và phạm vi tại hôm nay (BR-006,
    BR-013).
  - Mỗi route khai báo yêu cầu quyền bằng dependency; route chưa khai báo thì bị từ chối.
  - Thiếu vai trò trả `403 forbidden`. Tài nguyên ngoài phạm vi trả `404 not_found`, để không lộ là tài nguyên có tồn
    tại.
  - Khi `mustChangePassword` đúng, mọi operation trừ `GET /me`, `POST /me/password` và `POST /auth/logout` trả
    `403 password_change_required` (BR-002).
  - Dữ liệu trả về được lọc theo người xem: phần `personal` của hồ sơ chỉ có với HR và chính nhân viên (BR-033); lý do
    nghỉ trống với Quản lý không phải người duyệt (BR-067).

## Conventions

- **Base path and versioning:** `/api/v1`. Version chính chỉ tăng khi có breaking change.
- **Naming:** resource là danh từ số nhiều `kebab-case`, ví dụ `/leave-requests`. Field JSON là `camelCase`; backend
  dùng `snake_case` trong Python và đổi tên bằng alias của Pydantic. Giá trị cố định là `snake_case`, ví dụ
  `fixed_term`.
- **Actions:** chuyển trạng thái theo vòng đời dùng `POST` tới một sub-resource động từ, ví dụ
  `POST /leave-requests/{id}/approve`, thay vì `PATCH` trường `status`. Mỗi chuyển trạng thái là một quyền và một luật
  riêng.
- **Pagination:** `page` từ 1, `pageSize` mặc định 50, tối đa 100. Response có dạng `{ items, meta }`; `meta` gồm
  `page`, `pageSize`, `totalItems`, `totalPages`.
- **Filtering and sorting:** lọc bằng query parameter có tên rõ, ví dụ `?orgUnitId=…&status=active`. Sắp xếp mặc định
  ghi ở từng operation; baseline chưa cho client chọn cách sắp xếp.
- **Time:**
  - Ngày nghiệp vụ là `YYYY-MM-DD`; tháng là `YYYY-MM`.
  - Thời điểm là ISO 8601 theo UTC, có hậu tố `Z`.
  - "Hôm nay" trong luật tính theo `Asia/Ho_Chi_Minh`; giao diện đổi thời điểm sang giờ Việt Nam khi hiển thị.
- **Numbers:** số ngày nghỉ là số có bước 0,5. Từ M4, tiền là số nguyên đồng.
- **Concurrency:** tài nguyên sửa qua form có field `version`; gửi `version` đã đọc, khác thì nhận
  `409 version_conflict` (EC-016).
- **Idempotency:** MVP không cần `Idempotency-Key`. Gửi lặp một đơn nghỉ bị chặn bởi `leave_overlap` (BR-045); các
  chuyển trạng thái gửi lặp nhận `409 invalid_state` thay vì làm hai lần.
- **Rate limits:** `POST /auth/login` tối đa `login_rate_limit_per_ip` lần mỗi phút từ một IP, mặc định 10; vượt thì
  trả `429 rate_limited`. Giá trị nằm trong `app_settings`.
- **Files:** báo cáo xuất ra là XLSX, tạo khi được gọi, không lưu trên server. Giá trị bắt đầu bằng `=`, `+`, `-`, `@`
  được thêm `'` ở đầu (ARCHITECTURE: Threats).
