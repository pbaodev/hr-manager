# Flows

- **Status:** Draft
- **Updated:** 2026-10-30
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](../analysis/requirements.md) · [api](api.md) · [data](data.md) · [components](components.md) ·
  [design guide](../playbook/design.md)

> Mỗi luồng chính và mỗi use case của MVP có một sequence diagram. Use case của M3, M4 có sơ đồ khi làm milestone đó,
> trừ luồng chốt bảng lương, vì đó là một phần của architecture driver QA-001. Participant `api` được tách theo
> component khi cần: `core`, `service` của module, `db`.

## Mỗi request đã đăng nhập

- **Covers:** QA-003, ADR-0004; mọi operation trừ đăng nhập và refresh
- **Transaction:** một transaction cho cả request, mở ở `core`, commit khi route trả kết quả thành công

```mermaid
sequenceDiagram
  participant W as web
  participant C as api.core
  participant S as api.service
  participant D as db
  W->>C: Request kèm cookie access_token
  C->>C: Kiểm chữ ký và hạn của JWT
  alt Token sai hoặc hết hạn
    C-->>W: 401 unauthenticated
    W->>C: POST /auth/refresh rồi gửi lại request một lần
  end
  C->>D: Tải tài khoản theo id
  alt Bị khóa hoặc token_version khác
    C-->>W: 401 unauthenticated
  else Phải đổi mật khẩu và operation không thuộc nhóm được phép
    C-->>W: 403 password_change_required
  end
  C->>D: Tính vai trò và phạm vi tại hôm nay (BR-006, BR-013)
  C->>C: Dependency của route kiểm vai trò
  alt Không đủ vai trò
    C-->>W: 403 forbidden
  end
  C->>S: Gọi use case với người xem và phạm vi
  S->>D: Truy vấn có điều kiện lọc theo phạm vi
  alt Tài nguyên ngoài phạm vi
    S-->>C: NotFound
    C-->>W: 404 not_found
  else Thành công
    S-->>C: Kết quả
    C-->>W: 200 hoặc 201
  end
```

- **Failure handling:** lỗi luật từ `domain` và lỗi vi phạm constraint từ `db` được `core` đổi sang mã lỗi trong bảng
  Errors của [api](api.md#errors). Lỗi khác trả `500 internal_error` kèm `traceId`; transaction bị rollback.

## Đăng nhập và đổi refresh token

- **Covers:** US-001; BR-001 tới BR-003; ADR-0004
- **Transaction:** đăng nhập là một transaction, gồm cập nhật số lần sai và tạo refresh token

```mermaid
sequenceDiagram
  actor U as Người dùng
  participant W as web
  participant C as api.core
  participant I as identity.service
  participant D as db
  U->>W: Nhập mã nhân viên và mật khẩu
  W->>C: POST /auth/login
  C->>C: Kiểm số lần thử theo IP
  alt Quá login_rate_limit_per_ip
    C-->>W: 429 rate_limited
  end
  C->>I: Đăng nhập
  I->>D: Tải tài khoản theo mã nhân viên, khóa dòng
  alt Đang khóa tạm (BR-003)
    I-->>W: 423 account_throttled
  else Sai mật khẩu hoặc không có tài khoản
    I->>D: Tăng failed_logins, đủ max_failed_logins thì đặt throttled_until
    I-->>W: 401 invalid_credentials
  else Đúng
    I->>D: Đặt lại failed_logins, lưu bản băm refresh token mới
    I-->>W: 200 Me, đặt cookie access_token và refresh_token
    W-->>U: mustChangePassword đúng thì mở SCR-002, không thì SCR-003
  end
  Note over W,D: 15 phút sau, access token hết hạn
  W->>C: POST /auth/refresh kèm cookie refresh_token
  C->>I: Đổi token
  I->>D: Tìm bản băm, khóa dòng
  alt Token đã dùng rồi
    I->>D: Thu hồi mọi token cùng family_id
    I-->>W: 401 unauthenticated
  else Hợp lệ
    I->>D: Đánh dấu đã dùng, lưu token mới cùng family_id
    I-->>W: 204, đặt cookie mới
  end
```

- **Failure handling:** sai mã hay sai mật khẩu trả cùng một mã lỗi và mất cùng khoảng thời gian, để không đoán được mã
  nhân viên nào có tồn tại (EC-015).

## Tiếp nhận nhân viên mới

- **Covers:** UC-001; US-011, US-015, US-002
- **Transaction:** hồ sơ, khoảng làm việc, quá trình công tác đầu tiên, hợp đồng, sổ phép và nhật ký trong một
  transaction; tạo tài khoản là request riêng

```mermaid
sequenceDiagram
  actor H as HR
  participant W as web
  participant E as employees.service
  participant O as organization.public
  participant L as leave.public
  participant D as db
  H->>W: Điền bốn bước trên SCR-009 rồi xác nhận
  W->>E: POST /employees
  E->>O: Phòng ban hoạt động từ ngày vào làm? (BR-014)
  E->>E: Kiểm hợp đồng (BR-024, BR-028)
  E->>D: Cấp mã theo employee_code_format, INSERT employees, employment_periods, assignments, contracts
  E->>L: Mở sổ phép với phép năm cơ bản mặc định
  E->>D: INSERT audit_entries
  alt CCCD trùng (BR-022)
    D-->>E: Vi phạm unique index
    E-->>W: 409 national_id_taken, detail dẫn tới hồ sơ đó
  else Thành công
    E-->>W: 201 EmployeeDetail
    H->>W: Chọn tạo tài khoản
    W->>E: POST /accounts
    E-->>W: 201 kèm mật khẩu tạm, hiện một lần (BR-002)
  end
```

- **Failure handling:** lỗi ở bất kỳ bước nào làm rollback cả hồ sơ; không có hồ sơ dở dang (Postconditions của UC-001).

## Ghi nhận thay đổi công tác

- **Covers:** UC-002; US-013; BR-016 tới BR-018
- **Transaction:** cắt quá trình cũ, thêm quá trình mới và ghi nhật ký trong một transaction

```mermaid
sequenceDiagram
  actor H as HR
  participant W as web
  participant E as employees.service
  participant D as db
  H->>W: Chọn ngày hiệu lực D, phòng ban hoặc chức danh mới, lý do
  W->>E: POST /employees/{id}/assignments
  E->>D: Tải khoảng làm việc và các quá trình công tác của nhân viên
  E->>E: D trong khoảng làm việc? Có lý do nếu D trước hôm nay?
  E->>D: UPDATE quá trình chứa D, đặt đầu trên là D
  E->>D: INSERT quá trình mới từ D tới đầu dưới của quá trình kế tiếp, hoặc tới hết khoảng làm việc
  E->>D: INSERT audit_entries
  alt Đã có thay đổi cùng ngày (EC-002)
    E-->>W: 409 assignment_same_date
  else Hai khoảng chồng nhau do lỗi tính
    D-->>E: Vi phạm exclusion constraint
    E-->>W: 500 internal_error, rollback
  else Thành công
    E-->>W: 201 Assignment
  end
```

- **Failure handling:** exclusion constraint là lớp chặn cuối; nếu nó báo lỗi thì code tính khoảng đang sai, nên trả
  `500` và ghi log thay vì một mã lỗi nghiệp vụ.

## Ghi nhận nghỉ việc

- **Covers:** UC-003; US-014; BR-004, BR-019, BR-065
- **Transaction:** kết thúc các khoảng, hủy đơn sau ngày nghỉ việc, khóa tài khoản theo lịch và ghi nhật ký trong một
  transaction

```mermaid
sequenceDiagram
  actor H as HR
  participant W as web
  participant E as employees.service
  participant I as identity
  participant L as leave
  participant D as db
  H->>W: Nhập ngày làm việc cuối cùng L và lý do
  W->>E: PUT /employees/{id}/termination
  E->>I: HrGuard: người này là HR đang hoạt động cuối cùng? (BR-004)
  alt Là HR cuối cùng
    E-->>W: 409 last_hr_account
  end
  E->>D: Còn thay đổi công tác sau L? (EC-009)
  E->>D: Đặt đầu trên L+1 cho khoảng làm việc, quá trình công tác, hợp đồng, bổ nhiệm trưởng
  E->>E: Phát event EmployeeTerminated
  E->>L: Hủy đơn có ngày sau L, hoàn phép (BR-065)
  E->>I: Đặt lịch khóa tài khoản từ L+1
  E->>D: INSERT audit_entries
  E-->>W: 200 EmployeeDetail
```

- **Failure handling:** event chạy đồng bộ trong cùng transaction; handler lỗi thì cả thao tác rollback. Trạng thái Đã
  nghỉ việc suy ra từ khoảng làm việc, nên không cần job để chuyển trạng thái; job hằng ngày chỉ đặt `status` của tài
  khoản thành khóa cho đúng với màn hình tài khoản (BR-005).

## Gửi và duyệt đơn nghỉ

- **Covers:** UC-005; US-023, US-025, US-026, US-034; QA-001
- **Transaction:** gửi đơn là một transaction; duyệt là một transaction khác. Cả hai khóa dòng `leave_accounts` của nhân
  viên khi đơn là phép năm

```mermaid
sequenceDiagram
  actor N as Nhân viên
  actor Q as Người duyệt
  participant W as web
  participant L as leave.service
  participant O as organization.public
  participant D as db
  N->>W: Chọn loại nghỉ, ngày, buổi
  W->>L: POST /leave-requests/preview
  L-->>W: Số ngày theo lịch làm việc, số phép còn lại
  N->>W: Gửi đơn
  W->>L: POST /leave-requests
  L->>D: SELECT leave_accounts FOR UPDATE
  L->>D: Tính số dư từ leave_ledger_entries, trừ các đơn phép năm đang chờ
  alt Thiếu phép (BR-053)
    L-->>W: 409 leave_insufficient_balance
  end
  L->>O: Quản lý trực tiếp tại hôm nay (BR-012, BR-056)
  L->>D: INSERT leave_requests với half_days, người duyệt, INSERT notifications
  alt Chồng buổi với đơn khác (BR-045)
    D-->>L: Vi phạm exclusion constraint
    L-->>W: 409 leave_overlap
  else Thành công
    L-->>W: 201 LeaveRequest
  end
  Q->>W: Mở SCR-021, chọn duyệt
  W->>L: POST /leave-requests/{id}/approve
  L->>D: SELECT leave_accounts FOR UPDATE
  L->>D: Tải đơn, kiểm trạng thái Chờ duyệt và người duyệt (BR-058, BR-060)
  L->>D: Tính lại số dư
  alt Không còn đủ phép, ví dụ đơn khác vừa được duyệt (EC-024, EC-030)
    L-->>W: 409 leave_insufficient_balance, đơn vẫn chờ
  else Đủ
    L->>D: UPDATE đơn sang approved, INSERT leave_ledger_entries trừ phép, INSERT notifications, audit_entries
    L-->>W: 200 LeaveRequest
  end
```

- **Failure handling:** hai lần duyệt đồng thời của cùng một nhân viên phải chờ nhau ở `FOR UPDATE`; lần sau tính số dư
  sau khi lần trước đã commit. Lần duyệt gửi lặp nhận `409 invalid_state`. Đây là kịch bản của test QA-001.

## Cộng phép hằng tháng và phép tồn

- **Covers:** UC-006; US-030, US-031; EC-038
- **Transaction:** mỗi nhân viên một transaction; `job_runs` ghi kết quả cả lần chạy

```mermaid
sequenceDiagram
  participant R as Render cron
  participant J as jobs
  participant L as leave.public
  participant D as db
  R->>J: accrue-leave, 00:30 ngày 1 mỗi tháng, giờ Việt Nam
  J->>D: Các tháng chưa có job_runs thành công, tính tới tháng trước
  loop Mỗi tháng còn thiếu, mỗi nhân viên
    J->>L: Cộng phép tháng M cho nhân viên X
    L->>D: SELECT leave_accounts FOR UPDATE
    L->>L: Tháng đủ điều kiện? (BR-050), số ngày = 1/12 phép năm cơ bản (BR-048, BR-049)
    L->>D: INSERT leave_ledger_entries kind accrual, accrual_month M
    alt Đã cộng tháng M
      D-->>L: Vi phạm unique index, bỏ qua
    end
  end
  J->>D: INSERT job_runs thành công cho tháng M
  Note over R,D: Ngày 1/1 chạy roll-over-carryover (BR-051), ngày sau carryover_expiry chạy expire-carryover
```

- **Failure handling:** một nhân viên lỗi thì ghi log, đánh dấu lần chạy là có lỗi, và chạy tiếp người khác. Lần chạy
  sau cộng bù tháng còn thiếu. Unique index bảo đảm không cộng trùng kể cả khi hai lần chạy chồng nhau.

## Xuất báo cáo

- **Covers:** US-065, US-067, US-070; BR-127, BR-136
- **Transaction:** đọc trong một transaction chỉ đọc; ghi nhật ký xuất là transaction riêng

```mermaid
sequenceDiagram
  actor U as Quản lý hoặc HR
  participant W as web
  participant R as reporting.service
  participant D as db
  U->>W: Chọn bộ lọc rồi bấm Xuất
  W->>R: GET /reports/leave-usage/export?from=...&to=...
  R->>D: Truy vấn trong phạm vi của người xem (BR-127)
  R->>R: Tạo XLSX, thoát công thức ở ô bắt đầu bằng dấu bằng, cộng, trừ, a còng
  R->>D: INSERT audit_entries: người xuất, báo cáo, bộ lọc (BR-136)
  R-->>W: 200 file XLSX
```

- **Failure handling:** file được tạo trong bộ nhớ và trả về ngay; lỗi giữa chừng thì không có file nào được lưu.

## Chốt bảng lương

- **Covers:** UC-010; US-060; BR-091, BR-117; EC-072. Làm ở M4
- **Transaction:** một transaction

```mermaid
sequenceDiagram
  actor H as HR
  participant W as web
  participant P as payroll.service
  participant D as db
  H->>W: Bấm Chốt trên SCR-037, đã xem bảng lương có version v
  W->>P: Chốt tháng M với version v
  P->>D: Bảng lương có lỗi, phiếu thực lĩnh âm, hoặc ở trạng thái Cần tính lại? (BR-117)
  alt Còn lỗi
    P-->>W: 409 kèm danh sách lỗi
  end
  P->>D: UPDATE payroll_runs SET status closed WHERE month M AND status draft AND version v
  alt Không có dòng nào được cập nhật: HR khác đã chốt hoặc vừa tính lại
    P-->>W: 409 version_conflict
  else Một dòng
    P->>D: INSERT notifications cho từng nhân viên, INSERT audit_entries
    P-->>W: 200 PayrollRun
  end
```

- **Failure handling:** mở lại bảng công cần `FOR UPDATE` trên kỳ công và đọc `payroll_runs` với `FOR SHARE`, nên mở
  lại và chốt lương của cùng tháng không chạy chen nhau (BR-091).

## Jobs and external calls

Hệ thống không gọi dịch vụ ngoài. Mọi job do Render cron gọi bằng `python -m app.jobs <job>`, theo giờ Việt Nam.

| Job or call | Trigger | Timeout | Retry | When unavailable |
|---|---|---|---|---|
| `accrue-leave` | 00:30 ngày 1 mỗi tháng | 10 phút | Không retry ngay; lần chạy sau cộng bù tháng thiếu, unique index chặn cộng trùng (EC-038) | HR thấy cảnh báo job lỗi trên trang tổng quan |
| `roll-over-carryover` | 00:30 ngày 1/1 | 10 phút | Idempotent theo năm trong `job_runs`; chạy lại tay được | Như trên |
| `expire-carryover` | 00:30 ngày sau `carryover_expiry` | 10 phút | Idempotent theo năm | Như trên |
| `lock-terminated-accounts` | 00:15 hằng ngày | 5 phút | Idempotent; lần sau làm tiếp. Kiểm quyền ở mỗi request vẫn chặn người đã nghỉ việc, kể cả khi job chưa chạy | Như trên |
| `purge-refresh-tokens` | 03:00 hằng ngày | 5 phút | Idempotent | Bảng lớn dần; không ảnh hưởng đăng nhập |
| Job của M3, M4, như mở kỳ công | Thêm khi làm milestone đó | — | — | — |
