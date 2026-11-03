# API design

- **Status:** Draft
- **Updated:** 2026-11-03
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](../analysis/requirements.md) · [data](data.md) · [SPEC](../build/SPEC.md) ·
  [design guide](../playbook/design.md)

> Contract ở `contracts/openapi.yaml` là nguồn chính; file này ghi quy ước chung và bản đồ từ story `Must` tới
> operation. Đang làm ở #10: contract đã có đủ M1; M2 tới M6 viết ở các PR sau theo bảng Operations bên dưới.

## Style

- **Style:** REST trên HTTPS, body JSON. Thao tác nghiệp vụ không phải sửa dữ liệu thuần, như duyệt đơn hay chốt bảng
  lương, là `POST` tới một sub-resource động từ, ví dụ `POST /leave-requests/{id}/approve`. Một client duy nhất là web
  client của hệ thống (ADR-0007).
- **Contract:** `contracts/openapi.yaml`, viết tay trước khi code (chủ dự án chọn 2026-11-03). CI lint bằng job
  `contract`. Khi có code, CI xuất schema từ FastAPI rồi so với contract; lệch thì job đỏ. Type của web client sinh từ
  contract (ADR-0008).
- **Compatibility:** chỉ một client và deploy cùng lúc với backend, nên không giữ nhiều version song song. Đổi phá vỡ
  tương thích vẫn đi theo change-control loại Interface và tăng `info.version` của contract.

## Operations

Cột Actor ghi vai trò được gọi; phạm vi theo [permission matrix](../analysis/requirements.md#permission-matrix). "Tôi"
là người đang đăng nhập. Mã lỗi giải thích ở mục Errors. M1 có đủ trong contract; M2 tới M6 là thiết kế để viết contract
ở PR sau.

**M1: tài khoản, tổ chức, nhân sự, quy chế, câu hỏi, thông báo**

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `POST /auth/login` | US-001 | Không cần đăng nhập | `200` Session; đặt cookie | `401 invalid_credentials`; `403 account_throttled` (BR-003); `403 account_locked` (BR-005) |
| `POST /auth/logout` | US-001 | Đã đăng nhập | `204`; xóa phiên | — |
| `GET /auth/session` | US-001 | Đã đăng nhập | `200` Session: tài khoản, vai trò, phạm vi, có phải đổi mật khẩu | `401` |
| `POST /auth/password` | US-001 | Đã đăng nhập, kể cả khi phải đổi mật khẩu | `204` | `422 current_password_incorrect`; `422 password_too_short`, `422 password_reused` (BR-036) |
| `GET /accounts` | US-002 | HR | `200` trang tài khoản | — |
| `POST /employees/{employeeId}/account` | US-002 | HR | `201` Account kèm mật khẩu tạm, chỉ trả một lần | `409 account_exists` (BR-001) |
| `POST /accounts/{accountId}/lock` | US-002 | HR | `200` Account; xóa mọi phiên | `409 last_active_hr` (BR-004) |
| `POST /accounts/{accountId}/unlock` | US-002 | HR | `200` Account | `409 employee_terminated` (BR-005) |
| `POST /accounts/{accountId}/reset-password` | US-002 | HR | `200` mật khẩu tạm; xóa mọi phiên | — |
| `PUT /accounts/{accountId}/hr-role` | US-003 | HR | `200` Account; xóa mọi phiên của tài khoản đó | `409 last_active_hr` (BR-004) |
| `GET /positions` | US-005 | Đã đăng nhập | `200` danh sách | — |
| `POST /positions`, `PATCH /positions/{positionId}` | US-005 | HR | `201`, `200` Position | `409 position_name_taken` (BR-034) |
| `DELETE /positions/{positionId}` | US-005 | HR | `204` | `409 position_in_use` (BR-035) |
| `GET /org-units` | US-006, US-009 | Đã đăng nhập | `200` cây phòng ban tại `asOf`, kèm trưởng và số người | — |
| `POST /org-units` | US-006 | HR | `201` OrgUnit | `409 org_unit_parent_inactive` |
| `POST /org-units/{orgUnitId}/changes` | US-006 | HR | `201`: đổi tên, đổi cha hoặc giải thể từ ngày hiệu lực | `409 org_unit_cycle` (BR-008); `409 org_unit_not_empty` (BR-010) |
| `POST /org-units/{orgUnitId}/heads` | US-008 | HR | `201` HeadAssignment; bổ nhiệm cũ kết thúc ngày trước | `409 head_not_employed` (BR-011) |
| `POST /head-assignments/{headAssignmentId}/end` | US-008 | HR | `200` HeadAssignment | — |
| `GET /employees` | US-018, US-020 | Quản lý trong phạm vi; HR | `200` trang nhân viên; tìm không dấu | `403 out_of_scope` khi lọc phòng ban ngoài phạm vi (BR-013) |
| `POST /employees` | US-011 | HR | `201` Employee; tạo hồ sơ, quá trình công tác và hợp đồng trong một transaction | `409 national_id_taken` kèm hồ sơ đã có (BR-022) |
| `GET /employees/{employeeId}` | US-012, US-018 | Quản lý trong phạm vi, chỉ phần công việc (BR-033); HR | `200` Employee; header `ETag` | `404 not_found` khi ngoài phạm vi |
| `PATCH /employees/{employeeId}` | US-012 | HR; header `If-Match` | `200` Employee | `412 stale_version` (EC-016) |
| `GET /employees/{employeeId}/assignments` | US-013, US-018 | Quản lý trong phạm vi; HR | `200` quá trình công tác, gồm thay đổi sắp tới | `404` |
| `POST /employees/{employeeId}/assignments` | US-013 | HR | `201` Assignment | `422 reason_required` (BR-018); `409 assignment_same_day` (EC-002); `409 org_unit_inactive` (BR-014) |
| `POST /employees/{employeeId}/termination` | US-014 | HR | `200` Employee | `409 changes_after_last_day` kèm danh sách (EC-009) |
| `DELETE /employees/{employeeId}/termination` | US-014 | HR | `204` | `409 termination_in_effect` (BR-020) |
| `GET /employees/{employeeId}/contracts` | US-015 | HR | `200` danh sách | — |
| `POST /employees/{employeeId}/contracts`, `PATCH /contracts/{contractId}` | US-015 | HR | `201`, `200` Contract | `422 fixed_term_too_long` (BR-024); `409 contract_overlap` (BR-025); `409 consecutive_fixed_term` cần gửi lại với `confirmConsecutive` (BR-026); `422 probation_too_long` (BR-028); `409 contract_no_taken` (BR-037) |
| `GET /me/profile`, `PATCH /me/profile` | US-017 | Tôi; chỉ các trường ở BR-021 | `200` Profile | `422 validation_failed` khi gửi trường không được sửa |
| `GET /policies`, `GET /policies/{policyId}` | US-102 | Đã đăng nhập; nhân viên chỉ thấy phiên bản đã đăng | `200` quy chế đang dùng, phiên bản hiệu lực và các phiên bản trước | — |
| `GET /policy-versions/{versionId}` | US-101, US-102 | Đã đăng nhập; bản nháp chỉ HR | `200` PolicyVersion kèm các mục | `404` |
| `GET /policy-sections` | US-102 | Đã đăng nhập | `200` mục khớp `search` trong phiên bản hiệu lực | — |
| `POST /policies` | US-101 | HR | `201` Policy | — |
| `POST /policies/{policyId}/versions` | US-101 | HR | `201` bản nháp, chép từ phiên bản mới nhất | — |
| `PUT /policy-versions/{versionId}` | US-101 | HR | `200` PolicyVersion | `409 policy_version_published` (BR-192) |
| `POST /policy-versions/{versionId}/publish` | US-101 | HR | `200` PolicyVersion | `409 policy_effective_date_taken` (BR-192) |
| `GET /hr-questions` | US-104, US-105 | Tôi: câu hỏi của tôi; HR: mọi câu hỏi | `200` trang câu hỏi, lọc theo trạng thái; câu chờ lâu có cờ | — |
| `POST /hr-questions` | US-104 | Đã đăng nhập | `201` HrQuestion | — |
| `GET /hr-questions/{questionId}` | US-104, US-105 | Người hỏi; HR | `200` câu hỏi và các lượt | `404` |
| `POST /hr-questions/{questionId}/messages` | US-104, US-105 | Người hỏi hỏi thêm; HR trả lời | `201`; trạng thái đổi theo người viết | `404` |
| `GET /notifications` | US-114 | Tôi | `200` trang thông báo, mới nhất ở đầu, kèm số chưa đọc | — |
| `POST /notifications/{notificationId}/read` | US-114 | Người nhận | `200` Notification | `404` |

**M2: nghỉ phép**

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `GET /me/leave-balance`, `GET /employees/{employeeId}/leave-balance` | US-022 | Tôi; Quản lý trong phạm vi; HR | `200` số dư, phép tồn và hạn, đơn đã duyệt chưa tới ngày, sổ phép | `404` |
| `GET /leave-reasons` | US-074 | Đã đăng nhập | `200` lý do đang dùng và loại nghỉ hợp lệ | — |
| `GET /leave-coverage` | US-075 | Tôi; Quản lý; HR | `200` mức phủ theo buổi của phòng ban trong khoảng ngày | `403 out_of_scope` |
| `POST /leave-requests` | US-023 | Tôi; HR ghi thay | `201` LeaveRequest; `warnings` khi dưới ngưỡng (BR-146) hoặc trong giai đoạn hạn chế (BR-147) | `409 leave_overlap` (BR-045); `422 insufficient_leave` (BR-053); `422 leave_exceeds_max` (BR-047); `422 outside_employment` (BR-046); `422 reason_type_mismatch` (BR-142); `422 zero_days` (BR-044) |
| `POST /leave-requests/batch` | US-115 | Tôi | `201` các đơn, tạo cả hoặc không đơn nào (BR-153) | Như `POST /leave-requests`, kèm chỉ số đơn lỗi |
| `POST /leave-requests/{requestId}/cancel` | US-024 | Người gửi; HR | `200` | `409 request_not_cancellable` |
| `POST /leave-requests/{requestId}/change` | US-080 | Người gửi | `201` đơn mới thay đơn cũ | Như `POST /leave-requests` |
| `GET /approvals` | US-025, US-026 | Người duyệt, người duyệt thay; HR mọi đơn | `200` đơn chờ theo loại: nghỉ, làm thêm, giải trình | — |
| `POST /leave-requests/{requestId}/approve`, `/reject`, `/propose-change` | US-025, US-026, US-078 | Người duyệt, người duyệt thay, HR (BR-058) | `200` LeaveRequest | `409 request_not_pending`; `422 insufficient_leave` (EC-030); `422 rejection_reason_required` (BR-059); `403 self_approval` (BR-060) |
| `GET /leave-types`, `POST`, `PATCH /leave-types/{leaveTypeId}` | US-028 | Đọc: đã đăng nhập; ghi: HR | `200`, `201` LeaveType | `409 annual_leave_type_required` (BR-041) |
| `POST /leave-reasons`, `PATCH`, `DELETE /leave-reasons/{reasonId}` | US-073 | HR | `201`, `200`, `204` | `409 reason_in_use` (BR-143) |
| `GET /work-calendar`, `PUT /work-calendar/{date}`, `DELETE /work-calendar/{date}` | US-029 | Đọc: đã đăng nhập; ghi: HR | `200` kèm các đơn bị tính lại (BR-064) | `409 period_closed` (BR-090) |
| `POST /employees/{employeeId}/leave-adjustments` | US-032 | HR | `201` LeaveLedgerEntry | `422 reason_required` |
| Cộng phép, chuyển phép tồn, nhắc duyệt, thông báo đơn | US-030, US-031, US-034, US-077 | worker | Job theo lịch, không có operation | — |

**M3: chấm công**

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `GET /shifts`, `POST`, `PATCH /shifts/{shiftId}` | US-036 | HR | `200`, `201` Shift | `422 shift_invalid` (BR-068, BR-069) |
| `POST /shift-assignments/preview`, `POST /shift-assignments` | US-037 | HR | `200` người bị ảnh hưởng; `201` | `409 period_closed` (BR-090) |
| `PUT /employees/{employeeId}/timeclock-code` | US-038 | HR | `200` | `409 timeclock_code_taken` (BR-072) |
| `POST /punch-imports`, `POST /punch-imports/{importId}/confirm` | US-039 | HR | `201` bản xem trước: dòng sẽ lưu, trùng, bỏ qua; `200` khi xác nhận, công được tính lại | `409 period_closed` (BR-090); `422 file_unreadable` |
| `GET /me/timesheet`, `GET /employees/{employeeId}/timesheet` | US-040, US-041 | Tôi; Quản lý trong phạm vi; HR | `200` ngày công của một tháng | `404` |
| `POST /attendance-adjustments` | US-042 | Tôi | `201` | `409 period_closed`; `409 adjustment_exists` |
| `POST /attendance-adjustments/{adjustmentId}/approve`, `/reject` | US-043 | Người duyệt; HR | `200` | `409 request_not_pending` |
| `POST /overtime-requests` | US-044 | Tôi | `201` | `422 overtime_limit_exceeded` kèm số giờ còn được (BR-084); `422 overtime_inside_shift` (BR-083); `422 overtime_after_start` (BR-086) |
| `POST /overtime-requests/{requestId}/approve`, `/reject` | US-045 | Người duyệt; HR | `200` | `409 request_not_pending`; `422 overtime_limit_exceeded` |
| `POST /attendance-days/{employeeId}/{date}/resolve` | US-047 | HR | `200` AttendanceDay | `409 period_closed` |
| `POST /attendance-periods/{month}/close`, `/reopen`, `/remind` | US-048, US-117 | HR | `200` | `409 period_has_blockers` kèm danh sách (BR-089); `409 payroll_closed` (BR-091) |
| Tính công, thông báo và nhắc về đơn | US-040, US-116, US-117 | api khi dữ liệu nguồn đổi; worker | Không có operation riêng | — |

**M4: lương và phúc lợi**

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `GET /allowance-types`, `POST`, `PATCH /allowance-types/{typeId}` | US-050 | HR | `200`, `201` | `409 allowance_type_name_taken` (BR-097) |
| `GET /employees/{employeeId}/salary-records`, `POST` | US-051 | HR | `201` SalaryRecord | `422 below_minimum_wage` (BR-094); `409 salary_record_overlap` |
| `PUT /employees/{employeeId}/tax-insurance` | US-052 | HR | `200` | — |
| `GET /employees/{employeeId}/dependents`, `POST`, `PATCH /dependents/{dependentId}` | US-053 | HR | `200`, `201` | `409 dependent_claimed_twice` (BR-099) |
| `GET /payroll-parameters`, `POST /payroll-parameters` | US-054 | HR | `201` giá trị mới theo ngày hiệu lực | `409 parameter_date_taken`; `409 parameter_used_in_closed_payroll` (BR-123) |
| `POST /payroll-runs`, `POST /payroll-runs/{runId}/recalculate` | US-055 tới US-058 | HR | `201`, `200` PayrollRun kèm lỗi và cảnh báo từng phiếu | `409 timesheet_not_closed` (BR-102); `409 payroll_closed` (BR-118) |
| `GET /payroll-runs/{runId}`, `GET /payslips/{payslipId}` | US-055 | HR | `200` | `404` |
| `POST /payslips/{payslipId}/adjustments`, `DELETE /payslip-lines/{lineId}` | US-059 | HR | `201`, `204`; bảng lương về Nháp | `409 payroll_closed`; `422 reason_required` |
| `POST /payroll-runs/{runId}/close` | US-060 | HR | `200` | `409 payroll_has_errors` (BR-117); `409 payroll_stale`; `409 payroll_closed` (EC-072) |
| `GET /me/payslips`, `GET /me/payslips/{month}` | US-061 | Tôi; chỉ phiếu đã chốt (BR-122) | `200` | `404` |
| `GET /salary-records/below-minimum` | US-119 | HR | `200` bản ghi thấp hơn mức mới từ ngày hiệu lực | — |

**M5: báo cáo**

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `GET /reports/overview` | US-064 | Quản lý trong phạm vi; HR | `200` số chính và thẻ cảnh báo | `403 out_of_scope` |
| `GET /reports/workforce`, `/leave`, `/attendance`, `/payroll-cost` | US-065, US-067, US-068, US-069 | Quản lý trong phạm vi, chi phí lương chỉ số tổng hợp (BR-122); HR | `200`; nhóm dưới `report_min_group_size` người hiện "—" kèm lý do (BR-129) | `403 out_of_scope` |
| `GET /signals`, `GET /signals/{signalId}` | US-090, US-091 | Người xem được tín hiệu theo phạm vi và vai trò | `200` thẻ, số liệu và phân rã | `404` |
| `PUT /signals/{signalId}/reaction` | US-093 | Người xem | `200`: đánh giá, đóng, theo dõi | `404` |
| `PUT /me/muted-signal-types` | US-093 | Quản lý; HR | `200` | — |
| Tính tín hiệu, thông báo mức Cao | US-090, US-092 | worker | Job theo lịch | — |

**M6: AI**

Mọi operation AI trả `503 ai_unavailable` khi dịch vụ AI lỗi, chậm quá thời hạn hoặc đầu ra không đạt kiểm tra; web
client chuyển sang form và nội dung mẫu (BR-162). Không operation AI nào ghi dữ liệu nghiệp vụ (BR-157).

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| `POST /ai/leave-drafts` | US-082, US-083, US-084 | Tôi | `200`: các trường điền sẵn, hoặc câu hỏi lại, cảnh báo lý do, phương án nghỉ | `503 ai_unavailable` |
| `GET /leave-requests/{requestId}/ai-explanation` | US-085 | Người gửi; người duyệt | `200` giải thích tình huống và thẻ đề xuất | `404`; `503 ai_unavailable` |
| `GET /leave-requests/{requestId}/ai-summary` | US-088 | Người duyệt; HR | `200` tóm tắt tác động và phương án thay thế (BR-164) | `404`; `503 ai_unavailable` |
| `POST /action-proposals/{proposalId}/confirm`, `/dismiss` | US-085 | Người được xác nhận | `200`; core kiểm quyền và luật như khi người đó tự làm (BR-157) | `409 proposal_expired`; lỗi của thao tác gốc |
| `GET /insights`, `GET /insights/{insightId}` | US-096, US-097 | Quản lý, HR theo phạm vi | `200` insight kèm tín hiệu nguồn | `503 ai_unavailable`: client hiện thẻ của rule |
| `POST /assistant/conversations`, `POST /assistant/conversations/{conversationId}/turns` | US-107, US-108, US-110 | Tôi; công cụ chạy bằng phiên của tôi (BR-198) | `200` câu trả lời kèm nguồn, hoặc thẻ mở màn hình nghiệp vụ | `503 ai_unavailable` |
| `POST /assistant/conversations/{conversationId}/hr-question-draft` | US-112 | Tôi | `200` câu hỏi và tóm tắt soạn sẵn cho `POST /hr-questions` | `503 ai_unavailable` |

## Errors

- **Format:** RFC 9457 Problem Details, kiểu `application/problem+json`, có `type`, `title`, `status`, `detail` và
  thêm `code` ổn định cho client. Lỗi theo field nằm ở `errors`. Lỗi `500` có `traceId`, không có chi tiết kỹ thuật.
- **Mapping:** lỗi luật nghiệp vụ trả `409` khi xung đột với trạng thái hay dữ liệu đã có, `422` khi giá trị gửi lên
  vi phạm luật. Câu thông báo cho người dùng theo mục Messages của [ui](ui.md); mỗi `code` có một câu.
- **Warnings:** luật chỉ cảnh báo, như BR-146 hay BR-026 khi đã xác nhận, không là lỗi: response thành công có mảng
  `warnings` với `code` và `detail`.

| Code | HTTP | Meaning | Rule |
|---|---|---|---|
| `validation_failed` | 422 | Sai định dạng hoặc thiếu trường; `errors` ghi theo field | — |
| `unauthenticated` | 401 | Chưa đăng nhập hoặc phiên hết hạn | — |
| `password_change_required` | 403 | Phải đổi mật khẩu trước khi dùng chức năng khác | BR-002 |
| `forbidden` | 403 | Vai trò không được làm thao tác này | Permission matrix |
| `out_of_scope` | 403 | Lọc theo phòng ban ngoài phạm vi | BR-013 |
| `not_found` | 404 | Không có, hoặc người gọi không được biết đối tượng tồn tại | QA-003 |
| `stale_version` | 412 | Dữ liệu đã đổi từ khi mở; tải lại | EC-016 |
| `invalid_credentials` | 401 | Sai mã nhân viên hoặc mật khẩu, không nói phần nào sai | US-001 AC5 |
| `account_throttled` | 403 | Khóa tạm do nhập sai nhiều lần; `detail` ghi thời gian thử lại | BR-003 |
| `account_locked` | 403 | Tài khoản bị khóa hoặc nhân viên đã nghỉ việc | BR-005 |
| `current_password_incorrect` | 422 | Mật khẩu hiện tại sai khi đổi mật khẩu | — |
| `password_too_short`, `password_reused` | 422 | Mật khẩu mới không đạt luật | BR-036 |
| `account_exists` | 409 | Nhân viên đã có tài khoản | BR-001 |
| `last_active_hr` | 409 | Thao tác làm hệ thống không còn HR đang hoạt động | BR-004 |
| `employee_terminated` | 409 | Không mở khóa được tài khoản của người đã nghỉ việc | BR-005 |
| `position_name_taken`, `position_in_use` | 409 | Tên chức danh trùng; chức danh đã dùng chỉ ngừng dùng được | BR-034, BR-035 |
| `org_unit_cycle`, `org_unit_not_empty`, `org_unit_parent_inactive`, `org_unit_inactive` | 409 | Cây có vòng; giải thể khi còn người hoặc phòng ban con; phòng ban không hoạt động tại ngày hiệu lực | BR-008, BR-010, BR-014 |
| `head_not_employed` | 409 | Người được bổ nhiệm không làm việc trong cả khoảng bổ nhiệm | BR-011 |
| `national_id_taken` | 409 | Số CCCD trùng; `existingEmployeeId` dẫn tới hồ sơ đã có | BR-022 |
| `reason_required` | 422 | Thiếu lý do bắt buộc | BR-018 |
| `assignment_same_day` | 409 | Đã có thay đổi công tác cùng ngày hiệu lực | EC-002 |
| `changes_after_last_day`, `termination_in_effect` | 409 | Còn thay đổi sau ngày làm việc cuối; ngày làm việc cuối đã qua | EC-009, BR-020 |
| `fixed_term_too_long`, `probation_too_long` | 422 | Thời hạn hợp đồng vượt mức | BR-024, BR-028 |
| `contract_overlap`, `contract_no_taken`, `consecutive_fixed_term` | 409 | Hợp đồng chồng; số hợp đồng trùng; hợp đồng xác định thời hạn thứ ba cần xác nhận | BR-025, BR-037, BR-026 |
| `policy_version_published`, `policy_effective_date_taken` | 409 | Phiên bản đã đăng không sửa; đã có phiên bản cùng ngày hiệu lực | BR-192 |
| `ai_unavailable` | 503 | Dịch vụ AI không dùng được; client dùng form và nội dung mẫu | BR-162 |

Mã lỗi của M2 tới M6 ở bảng Operations được thêm vào bảng này khi viết contract của module đó.

**Status codes**

| HTTP | When |
|---|---|
| 200 | Đọc, sửa hoặc thao tác thành công |
| 201 | Tạo thành công; kèm header `Location` |
| 204 | Xóa, hủy hoặc đăng xuất thành công, không có body |
| 401 | Chưa đăng nhập, phiên hết hạn, hoặc đăng nhập sai |
| 403 | Đã đăng nhập nhưng không có quyền; tài khoản bị khóa; phải đổi mật khẩu |
| 404 | Không có tài nguyên, hoặc người gọi không được biết tài nguyên đó tồn tại |
| 409 | Xung đột với trạng thái hay dữ liệu hiện có |
| 412 | `If-Match` không khớp version hiện tại |
| 422 | Đầu vào sai định dạng hoặc vi phạm luật về giá trị |
| 429 | Gọi quá giới hạn |
| 500 | Lỗi không lường trước; có `traceId` |
| 503 | Dịch vụ AI không dùng được |

## Auth

- **Authentication:** theo ADR-0010. `POST /auth/login` đặt cookie phiên `HttpOnly`, `Secure`, `SameSite=Lax`, đường dẫn
  `/api`. Phiên hết hạn sau `session_idle_minutes` phút không dùng và sau `session_max_hours` giờ kể từ khi đăng nhập
  (assumption, tham số mới thêm vào domain khi chốt). Mọi request ghi (`POST`, `PUT`, `PATCH`, `DELETE`) gửi header
  `X-CSRF-Token` bằng giá trị trả về trong Session; sai thì `403 forbidden`.
- **Phải đổi mật khẩu:** khi `mustChangePassword` đúng, mọi operation trừ `GET /auth/session`, `POST /auth/password` và
  `POST /auth/logout` trả `403 password_change_required` (BR-002).
- **Authorization:** kiểm ở backend cho mọi operation, theo vai trò (Nhân viên, Quản lý, HR) và phạm vi phòng ban tại
  hôm nay (BR-013). Đối tượng ngoài phạm vi trả `404 not_found`, để không lộ là đối tượng có tồn tại; thao tác vai trò
  không được làm trả `403 forbidden`. Mỗi lần từ chối ghi log (QA-003). Quản lý nhận các trường theo BR-033; trường
  không được xem không có trong response, không trả `null`.

## Conventions

- **Base path and versioning:** `/api/v1`. Đổi phá vỡ tương thích theo change-control loại Interface.
- **Naming:** đường dẫn `kebab-case`, resource số nhiều, ví dụ `/leave-requests`; field `camelCase`; giá trị trạng thái
  theo mã trong domain, ví dụ `pending`, `awaiting`.
- **Pagination:** `page` từ 1, `pageSize` tới 100, mặc định 20; response `{ items, meta }` với `meta.totalItems`.
- **Filtering and sorting:** `search` tìm không dấu, không phân biệt hoa thường (EC-019); lọc bằng tên field, ví dụ
  `?status=terminated&orgUnitId=…&includeSubunits=true`; sắp bằng `sort=fullName` hoặc `sort=-sentAt`.
- **Time:** ngày nghiệp vụ dạng `YYYY-MM-DD`, theo giờ Việt Nam; thời điểm dạng ISO 8601 có múi giờ. Xem tại một ngày
  bằng `asOf=YYYY-MM-DD`, mặc định hôm nay.
- **Numbers:** tiền là số nguyên đồng; số ngày là số thập phân, tối đa bốn chữ số sau dấu phẩy trong sổ phép. Client
  không tự cộng số dư; số dư do server trả.
- **Concurrency:** resource sửa được trả `ETag`; `PATCH` và `PUT` của hồ sơ gửi `If-Match` (EC-016).
- **Idempotency:** `POST` tạo đơn, nhập file và tính lương nhận header `Idempotency-Key`; gửi lại cùng key trong 24 giờ
  thì nhận lại kết quả lần đầu.
- **Rate limits:** `POST /auth/login` tối đa 10 lần mỗi phút cho một địa chỉ IP (assumption), ngoài khóa tạm theo
  BR-003; vượt thì `429`.
