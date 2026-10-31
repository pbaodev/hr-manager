# UI design

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [UI flow](../analysis/ui-flow.md) · [components](components.md) · [api](api.md) ·
  [design guide](../playbook/design.md)

> Điền ở Phase 3 khi sản phẩm có giao diện; nếu không thì bỏ file. UI flow ghi người dùng thấy gì và đi qua màn hình
> nào; file này ghi quy tắc giao diện chung cho mọi màn hình: design system, trạng thái, định dạng và accessibility.
> Cách xây frontend nằm ở mục Frontend của components. Màn hình nào làm khác quy tắc chung thì ghi ở mục màn hình đó
> trong UI flow. Dòng in nghiêng là ví dụ, xóa khi điền.

## Design sources

| Kind | Link | Version or date |
|---|---|---|
| *Wireframe* | *[link]* | *[YYYY-MM-DD]* |
| *Mockup* | *[link]* | *[YYYY-MM-DD]* |
| *Component library* | *[tên thư viện, dẫn ADR nếu ảnh hưởng tới kiến trúc]* | *[version]* |

## Design tokens

Giá trị dùng chung, đặt trong code hoặc config của frontend thay vì viết thẳng vào từng màn hình.

| Token | Value | Used for |
|---|---|---|
| *`color.primary`* | *[mã màu]* | *Nút chính, link* |
| *`color.danger`* | *[mã màu]* | *Lỗi, thao tác xóa* |
| *`font.size.base`* | *[16px]* | *Nội dung* |
| *`spacing.unit`* | *[4px]* | *Mọi khoảng cách là bội số của giá trị này* |

## Screen states

Áp dụng cho mọi màn hình. Màn hình chỉ cần các trạng thái có thật với nó.

| State | Required behavior |
|---|---|
| Loading | Giữ khung trang; hiện skeleton hoặc spinner ở vùng đang tải |
| Empty | Nói rõ không có dữ liệu; phân biệt "chưa có dữ liệu" với "không có kết quả khớp bộ lọc" |
| Validation error | Giữ dữ liệu đã nhập; báo lỗi ngay dưới trường; focus vào trường lỗi đầu tiên |
| Server error | Thông báo ngắn, có cách thử lại; không hiện chi tiết kỹ thuật |
| Unauthenticated | Xóa phiên, chuyển tới đăng nhập, quay lại trang cũ sau khi đăng nhập |
| Forbidden | Báo không có quyền, kèm đường quay lại |
| Saving | Khóa nút gửi để tránh gửi hai lần |
| Success | Xác nhận kết quả; tải lại dữ liệu bị ảnh hưởng |
| AI output | Đánh dấu là gợi ý; người dùng xác nhận trước khi kết quả được dùng; bỏ dòng này khi không có tính năng AI |

## Formats

- **Date and time:** [ví dụ `dd/MM/yyyy HH:mm`, hiển thị theo timezone của người dùng; lưu theo cách ghi ở data]
- **Numbers and currency:** [ví dụ `1.234,56`; đơn vị tiền]
- **Responsive:** [breakpoint, ví dụ mobile ≤ 768px, desktop > 1024px; màn hình nào không hỗ trợ mobile]

## Accessibility

- **Target:** [ví dụ WCAG 2.2 mức AA]
- **Rules:** [ví dụ mọi input có label; không thể hiện trạng thái chỉ bằng màu; mọi thao tác làm được bằng bàn phím]
- **Checked by:** [công cụ tự động, thử bằng bàn phím, screen reader]

## Messages

Câu thông báo ghi chuyện gì xảy ra và người dùng nên làm gì. Lỗi có mã trong [api](api.md) thì mỗi mã có một câu.

| Situation | Message |
|---|---|
| *`booking_conflict` (BR-001)* | *Phòng đã có người đặt trong khung giờ này. Hãy chọn giờ khác.* |
