# ADR-0004: Xác thực tự làm bằng JWT ngắn hạn và refresh token lưu DB

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án chọn JWT
- **Drivers:** QA-003; BR-001 tới BR-006, BR-036; A-004
- **Related:** ADR-0002, ADR-0003, ADR-0005, [requirements](../requirements.md#permission-matrix)

## Context

Tên đăng nhập là mã nhân viên, vì không phải ai cũng có email công việc (A-004). HR đặt lại mật khẩu; người dùng phải đổi
mật khẩu ở lần đăng nhập đầu (BR-002); sai 5 lần thì khóa tạm (BR-003). Tài khoản bị khóa hoặc nhân viên nghỉ việc thì
không được dùng hệ thống nữa (BR-004, BR-005). Vai trò Quản lý suy ra từ bổ nhiệm trưởng tại ngày hôm nay (BR-006), nên
quyền đổi theo thời gian mà không ai thao tác.

JWT thuần không thu hồi được trước khi hết hạn, nên người vừa bị khóa vẫn gọi được API tới lúc token hết hạn. Điều đó trái
với QA-003.

## Decision

- **Mật khẩu:** băm bằng argon2id; độ dài tối thiểu theo BR-036.
- **Access token:** JWT ký bằng khóa bí mật của server, sống 15 phút, chỉ chứa id tài khoản và `token_version`. Không đưa
  vai trò hay phạm vi vào token.
- **Refresh token:** chuỗi ngẫu nhiên, chỉ lưu bản băm trong PostgreSQL, sống 12 giờ, đổi mới mỗi lần dùng. Dùng lại một
  refresh token đã đổi thì thu hồi cả chuỗi.
- **Thu hồi ngay:** mỗi request tra tài khoản theo id để kiểm trạng thái và `token_version`. Khóa tài khoản, đặt lại mật
  khẩu, đổi mật khẩu hay thu hồi vai trò HR thì tăng `token_version` và xóa refresh token của tài khoản đó.
- **Phân quyền:** vai trò và phạm vi quản lý tính ở backend trên mỗi request, từ dữ liệu tại ngày hôm nay (BR-006,
  BR-013).
- **Lưu token ở trình duyệt:** cả hai token nằm trong cookie `HttpOnly`, `Secure`, `SameSite=Strict`. Frontend và API
  cùng domain (ADR-0005). Request ghi dữ liệu kiểm thêm header `Origin`.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| JWT ngắn hạn, refresh token lưu DB, kiểm `token_version` mỗi request | Chuẩn phổ biến, học được cách làm JWT đúng; thu hồi ngay nhờ bước kiểm tài khoản | Nhiều thành phần hơn session; mỗi request vẫn đọc DB một lần, nên mất ưu điểm "không trạng thái" của JWT | QA-003: đạt nhờ kiểm tài khoản mỗi request |
| Session id trong cookie, session lưu DB | Đơn giản nhất; thu hồi bằng xóa session | Ít học được về token; cần dọn session hết hạn | QA-003: đạt |
| Dịch vụ auth ngoài | Có sẵn nhiều tính năng | Thiết kế quanh email; đăng nhập bằng mã nhân viên và HR đặt lại mật khẩu phải lách; phụ thuộc nhà cung cấp | QA-003: đạt, nhưng luật tài khoản nằm một phần ngoài hệ thống |

## Consequences

- **Easier:** người bị khóa mất quyền ngay ở request kế tiếp; quyền theo phạm vi luôn đúng với ngày hôm nay.
- **Harder:** phải tự làm và test đổi mới refresh token, phát hiện dùng lại token, khóa tạm; cần một khóa ký JWT trong
  secret của mỗi môi trường.
- **Follow-up:** test tự động cho mọi dòng của ma trận phân quyền (QA-003); ghi mối đe dọa về token vào mục Threats của
  ARCHITECTURE (Issue #8).

## Revisit when

Cần đăng nhập một lần với hệ thống khác của công ty, có ứng dụng di động gọi API, hoặc bước kiểm tài khoản mỗi request
làm vượt QA-004.
