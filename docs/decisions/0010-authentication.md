# ADR-0010: Đăng nhập bằng mã nhân viên, phiên lưu ở server

- **Status:** Proposed
- **Date:** 2026-11-03
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Drivers:** QA-003, QA-007; BR-003, BR-036, BR-198
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md#architecture-drivers), [requirements](../analysis/requirements.md#non-goals), #8, ADR-0007

## Context

- Người dùng đăng nhập bằng mã nhân viên và mật khẩu (US-001). Không đăng nhập bằng Google hay Microsoft; không tự đặt
  lại mật khẩu qua email, HR đặt lại (Non-goals của M1). Chưa chắc mọi nhân viên có email công việc (A-004).
- Nhập sai nhiều lần thì khóa tạm (BR-003); mật khẩu mới theo BR-036; tài khoản HR đặt lại phải đổi mật khẩu khi đăng
  nhập (SCR-002).
- Khi HR khóa tài khoản, thu hồi vai trò HR hay nhân viên nghỉ việc, quyền phải mất ngay, kể cả với phiên đang mở
  (QA-003).
- AI HR Assistant chạy bằng phiên của người hỏi, không có vai trò hệ thống riêng (BR-198).
- Web client và backend cùng một ứng dụng (ADR-0007).

## Decision

Đề xuất, chờ chủ dự án chọn: backend tự làm đăng nhập. Mật khẩu băm bằng Argon2id. Sau khi đăng nhập, backend tạo phiên
lưu trong DB và gửi cookie `HttpOnly`, `Secure`, `SameSite=Lax`; thao tác ghi có kiểm CSRF. Khóa tài khoản hay đổi
vai trò thì xóa các phiên của người đó.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Phiên lưu trong DB, cookie `HttpOnly` | Thu hồi tức thì bằng cách xóa phiên; token không nằm trong JavaScript; đơn giản khi client và backend cùng domain | Mỗi request đọc phiên từ DB; phải tự làm CSRF | QA-003: đạt, kể cả với phiên đang mở; BR-198: Assistant dùng chính phiên này |
| JWT ngắn hạn và refresh token lưu DB | Không đọc DB ở mỗi request; dùng được cho app di động sau này | Quyền thay đổi chỉ có tác dụng khi JWT hết hạn, trừ khi giữ danh sách thu hồi; phức tạp hơn cho một web app | QA-003: đạt sau tối đa thời hạn JWT, hoặc phải thêm danh sách thu hồi |
| Dịch vụ auth ngoài | Có sẵn khóa tạm, băm mật khẩu, MFA | Thường xoay quanh email; đăng nhập bằng mã nhân viên và HR đặt lại mật khẩu phải tùy biến; thêm chi phí và dữ liệu nhân viên ra bên thứ ba (Q-035) | QA-003: đạt nếu đồng bộ được trạng thái tài khoản; thêm một hệ thống ngoài |

## Consequences

- **Easier:** khóa tài khoản có hiệu lực ngay; không phải giữ token ở client.
- **Harder:** tự làm và tự test phần mật khẩu, khóa tạm và CSRF; app di động riêng sau này cần thêm cách cấp token.
- **Follow-up:** ghi thời hạn phiên, cách xử lý CSRF và rate limit đăng nhập ở [api](../design/api.md) và mục
  Cross-cutting concerns của ARCHITECTURE.

## Revisit when

Có app di động riêng; công ty muốn đăng nhập một lần bằng tài khoản Google hay Microsoft; hoặc cần MFA.
