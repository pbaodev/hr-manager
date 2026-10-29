# API design

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](../requirements.md) · [SPEC](../SPEC.md) · [design guide](../playbook/design.md)

> Điền ở Phase 3 khi hệ thống có interface cho client hoặc cho hệ thống khác. Contract là nguồn chính, ví dụ một file
> OpenAPI; file này ghi quy ước chung và bản đồ từ user story tới operation. Hệ thống không có API qua mạng thì ghi
> interface chính, như CLI, event hay module public, theo cùng cấu trúc. Dòng in nghiêng là ví dụ, xóa khi điền.

## Style

- **Style:** [REST / RPC / GraphQL / event; dẫn ADR]
- **Contract:** [nơi lưu; viết trước code hay sinh từ code; cách sinh type cho client]. Default là
  `contracts/openapi.yaml`, viết trước code, CI lint bằng job `contract`.
- **Compatibility:** [CI phát hiện breaking change thế nào; cách đánh version]

## Operations

| Operation | Story | Actor and permission | Success | Errors |
|---|---|---|---|---|
| *`POST /bookings`* | *US-001* | *Thành viên đã đăng nhập* | *`201`, trả Booking* | *`409 booking_conflict` (BR-001); `422 slot_too_long` (BR-002)* |
| *`DELETE /bookings/{id}`* | *US-003* | *Người đặt hoặc quản trị* | *`204`* | *`403` khi không phải người đặt; `409 booking_started` (BR-004)* |

## Errors

- **Format:** [ví dụ RFC 9457 problem details với `type`, `title`, `status`, `detail`, thêm `code`]
- **Mapping:** [lỗi domain đổi sang HTTP status thế nào; lỗi không lường trước trả `500` và không lộ chi tiết]

| Code | HTTP | Meaning | Rule |
|---|---|---|---|
| *`validation_failed`* | *422* | *Đầu vào sai định dạng; `errors` ghi lỗi theo từng field* | *—* |
| *`booking_conflict`* | *409* | *Khung giờ chồng lên một lịch đã xác nhận* | *BR-001* |

**Status codes**

| HTTP | When |
|---|---|
| *200* | *Đọc hoặc sửa thành công* |
| *201* | *Tạo thành công; kèm header `Location`* |
| *204* | *Xóa hoặc hủy thành công, không có body* |
| *401* | *Chưa đăng nhập hoặc phiên đã hết hạn* |
| *403* | *Đã đăng nhập nhưng không có quyền* |
| *404* | *Không có tài nguyên, hoặc người gọi không được biết tài nguyên đó tồn tại* |
| *409* | *Xung đột với trạng thái hiện tại: trùng, sai trạng thái* |
| *422* | *Đầu vào sai định dạng hoặc vi phạm luật về giá trị* |
| *500* | *Lỗi không lường trước; không lộ chi tiết, có `traceId`* |

## Auth

- **Authentication:** [cơ chế, thời hạn phiên, nơi lưu token]
- **Authorization:** [mô hình quyền, ví dụ theo vai cộng theo chủ sở hữu; kiểm ở tầng nào]

## Conventions

- **Base path and versioning:** [ví dụ `/api/v1`; breaking change theo change-control loại Interface]
- **Naming:** [cách đặt tên resource và field; ví dụ resource số nhiều `kebab-case`, field `camelCase`]
- **Pagination:** [cách phân trang danh sách; ví dụ `page`, `pageSize` ≤ 100, response `{ items, meta }`]
- **Filtering and sorting:** [ví dụ `?search=…&sortBy=createdAt&sortDirection=desc`]
- **Time:** [ví dụ ISO 8601 có timezone]
- **Idempotency:** [operation nào nhận `Idempotency-Key`, nếu cần]
- **Rate limits:** [giới hạn, nếu có]
