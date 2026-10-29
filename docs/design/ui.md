# UI design

- **Status:** Draft
- **Updated:** 2026-10-30
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [UI flow](../ui-flow.md) · [components](components.md) · [api](api.md) ·
  [design guide](../playbook/design.md) · ADR-0006

> Quy tắc giao diện chung cho mọi màn hình: design system, trạng thái, định dạng, accessibility và câu thông báo. Người
> dùng thấy gì ở từng màn hình nằm ở UI flow; cách xây frontend nằm ở mục Frontend của components.

## Design sources

| Kind | Link | Version or date |
|---|---|---|
| Wireframe | Nội dung và trạng thái từng màn hình ở [UI flow](../ui-flow.md); chưa có bản vẽ riêng | 2026-10-30 |
| Mockup | Chưa có. Màn hình được dựng thẳng bằng component của Mantine theo quy tắc ở file này | — |
| Component library | Mantine, theo ADR-0006 | Bản ổn định mới nhất lúc dựng project, ghi trong lockfile |

## Design tokens

Token đặt trong theme của Mantine, trong một file của frontend. Màn hình không viết thẳng mã màu, cỡ chữ hay khoảng cách.

| Token | Value | Used for |
|---|---|---|
| `primaryColor` | Bảng màu `blue` của Mantine, sắc độ 6 | Nút chính, link, mục menu đang chọn |
| `color.success` | `green` 7 | Đơn đã duyệt, thao tác thành công |
| `color.warning` | `yellow` 7 | Đơn chờ duyệt, cảnh báo như hợp đồng sắp hết hạn |
| `color.danger` | `red` 7 | Lỗi, đơn bị từ chối, thao tác không hoàn tác được |
| `color.muted` | `gray` 6 | Đơn đã hủy, dữ liệu đã nghỉ việc |
| `fontFamily` | `Inter`, rồi font hệ thống; có đủ dấu tiếng Việt | Mọi chữ |
| `fontSizes.md` | 16px | Nội dung; input trên điện thoại không nhỏ hơn 16px để trình duyệt không tự phóng to |
| `spacing` | Bội số của 4px, theo thang `xs` tới `xl` của Mantine | Mọi khoảng cách |
| `radius` | `sm`, 4px | Nút, input, thẻ |
| `breakpoints.sm` | 768px | Ranh giới giữa bố cục điện thoại và bố cục máy tính |

Màu trạng thái luôn đi kèm chữ hoặc biểu tượng, ví dụ nhãn "Đã duyệt", không chỉ dùng màu.

## Screen states

| State | Required behavior |
|---|---|
| Loading | Giữ khung trang và menu; hiện skeleton ở vùng đang tải. Lần tải lại khi đã có dữ liệu thì giữ dữ liệu cũ, hiện chỉ báo nhỏ |
| Empty | Nói rõ không có dữ liệu và việc nên làm, ví dụ "Bạn chưa có đơn nghỉ nào." kèm nút Gửi đơn. Khi có bộ lọc thì ghi "Không có kết quả khớp bộ lọc." kèm nút Xóa bộ lọc |
| Validation error | Giữ dữ liệu đã nhập; báo lỗi ngay dưới trường; focus vào trường lỗi đầu tiên. Lỗi `422` có `errors` theo field thì gắn vào đúng trường |
| Business rule error | Lỗi `409` hiện câu ở bảng Messages trong một thông báo nằm trên nút gửi; dữ liệu nhập giữ nguyên |
| Server error | Lỗi `500` hoặc mất mạng: "Có lỗi xảy ra. Thử lại sau ít phút." kèm nút Thử lại và mã `traceId` dạng chữ nhỏ để báo HR |
| Unauthenticated | Thử refresh một lần; không được thì chuyển tới SCR-001 và quay lại trang cũ sau khi đăng nhập |
| Password change required | Lỗi `403 password_change_required` hoặc `mustChangePassword` đúng: chuyển tới SCR-002, không cho đi màn hình khác |
| Forbidden | "Bạn không có quyền xem trang này." kèm nút về Trang chủ |
| Not found | "Không tìm thấy dữ liệu, hoặc bạn không có quyền xem." kèm nút quay lại. Cùng một câu cho hai trường hợp, theo cách API trả `404` |
| Saving | Khóa nút gửi và hiện chỉ báo trên nút cho tới khi có kết quả |
| Success | Thông báo ngắn ở góc màn hình, tự ẩn sau 4 giây; tải lại dữ liệu bị ảnh hưởng |
| Destructive action | Hủy đơn, ghi nhận nghỉ việc, thu hồi vai trò HR, khóa tài khoản: hộp thoại xác nhận nói rõ hậu quả; nút xác nhận màu `danger` |

## Formats

- **Language:** chỉ tiếng Việt; chưa cần đa ngôn ngữ.
- **Date and time:**
  - Ngày là `dd/MM/yyyy`, ví dụ `05/03/2026`.
  - Tháng là `MM/yyyy`; giờ là `HH:mm` theo 24 giờ.
  - Ngày kèm buổi là `05/03/2026 (sáng)`.
  - Mọi thời điểm hiển thị theo giờ Việt Nam (`Asia/Ho_Chi_Minh`), kể cả khi máy người dùng đặt múi giờ khác.
  - Ô chọn ngày dùng locale `vi` của dayjs, tuần bắt đầu từ thứ Hai.
- **Numbers:**
  - Số nghìn ngăn bằng dấu chấm, phần thập phân bằng dấu phẩy, ví dụ `1.234,5`.
  - Số ngày nghỉ có tối đa một chữ số thập phân, ví dụ `1,5 ngày`.
  - Tỷ lệ là phần trăm, một chữ số thập phân, ví dụ `10,5%`.
- **Currency, từ M4:** số nguyên đồng kèm `₫`, ví dụ `12.000.000 ₫`.
- **Names and codes:** họ tên hiển thị đúng như nhập; mã nhân viên in đậm cạnh họ tên ở mọi danh sách.
- **Responsive:**

  | Group | Screens | Support |
  |---|---|---|
  | Nhân viên và duyệt đơn | SCR-001 tới SCR-004, SCR-019 tới SCR-022 | Điện thoại từ 360px tới máy tính. Dưới 768px: menu thu vào nút ở thanh trên; bảng chuyển thành danh sách thẻ; form một cột; nút chính kéo hết chiều ngang |
  | HR và báo cáo | SCR-007 tới SCR-016, SCR-023, SCR-024, SCR-040 tới SCR-043 | Máy tính từ 1024px. Trên điện thoại vẫn mở được và cuộn ngang bảng, nhưng không tối ưu |

## Accessibility

- **Target:** WCAG 2.2 mức AA cho các màn hình của MVP.
- **Rules:**
  - Mọi input có label hiện trên màn hình, không chỉ dùng placeholder.
  - Lỗi của trường được nối với input bằng `aria-describedby`.
  - Không thể hiện trạng thái chỉ bằng màu.
  - Độ tương phản chữ tối thiểu 4,5:1.
  - Mọi thao tác làm được bằng bàn phím, có viền focus rõ.
  - Hộp thoại giữ focus bên trong và đóng được bằng `Esc`.
  - Vùng chạm trên điện thoại tối thiểu 24 × 24 px; nút chính cao 44px.
  - Bảng có tiêu đề cột thật (`th`); biểu đồ báo cáo có bảng số liệu đi kèm.
  - Thông báo thành công và lỗi gửi được tới screen reader qua vùng `aria-live`.
- **Checked by:**
  - `axe` chạy trong test E2E trên các màn hình của MVP.
  - Thử bằng bàn phím cho luồng đăng nhập, gửi đơn và duyệt đơn, ghi kết quả vào [testing](../testing.md).

## Messages

Câu thông báo ghi chuyện gì xảy ra và người dùng nên làm gì. Mỗi mã lỗi ở [api](api.md#errors) có một câu; phần trong
ngoặc vuông lấy từ dữ liệu của lỗi. API cũng trả câu tương ứng trong `detail`; giao diện ưu tiên câu ở bảng này.

| Situation | Message |
|---|---|
| `validation_failed` | Kiểm tra lại các trường được đánh dấu. |
| `unauthenticated` | Phiên đăng nhập đã hết. Hãy đăng nhập lại. |
| `invalid_credentials` (BR-003) | Mã nhân viên hoặc mật khẩu không đúng. |
| `account_throttled` (BR-003) | Bạn đã nhập sai nhiều lần. Thử lại sau [số phút] phút hoặc nhờ HR mở khóa. |
| `rate_limited` | Có quá nhiều lần đăng nhập từ thiết bị này. Thử lại sau một phút. |
| `password_change_required` (BR-002) | Bạn cần đặt mật khẩu mới trước khi tiếp tục. |
| `forbidden` | Bạn không có quyền làm thao tác này. |
| `not_found` | Không tìm thấy dữ liệu, hoặc bạn không có quyền xem. |
| `version_conflict` (EC-016) | Dữ liệu vừa được người khác sửa. Tải lại để xem bản mới rồi sửa lại. |
| `invalid_state` | Trạng thái đã thay đổi, ví dụ đơn vừa được duyệt. Tải lại để xem trạng thái mới. |
| `name_taken` (BR-034, BR-040) | Tên này đã tồn tại. Hãy chọn tên khác. |
| `account_exists` (BR-001) | Nhân viên này đã có tài khoản. |
| `last_hr_account` (BR-004) | Hệ thống phải còn ít nhất một HR đang hoạt động. Hãy gán vai trò HR cho người khác trước. |
| `employee_terminated` (BR-005) | Nhân viên đã nghỉ việc nên không mở khóa được tài khoản. |
| `password_too_short` (BR-036) | Mật khẩu phải dài ít nhất [số ký tự] ký tự. |
| `password_reused` (BR-036) | Mật khẩu mới phải khác mật khẩu hiện tại. |
| `org_cycle` (BR-008) | Không thể chuyển phòng ban vào nhánh con của chính nó. |
| `org_root_rule` (BR-007) | Phòng ban gốc chỉ đổi được tên; công ty luôn có đúng một phòng ban gốc. |
| `org_unit_inactive` (BR-014) | Phòng ban [tên] không hoạt động vào ngày [ngày]. Chọn phòng ban khác hoặc đổi ngày. |
| `head_overlap` (BR-011) | Phòng ban đã có trưởng trong khoảng thời gian này. Kết thúc bổ nhiệm hiện tại trước. |
| `head_not_employed` (BR-011) | Người được chọn không làm việc trong suốt khoảng bổ nhiệm. |
| `national_id_taken` (BR-022) | Số CCCD đã có ở hồ sơ [mã nhân viên]. Mở hồ sơ đó để kiểm tra. |
| `effective_date_outside_employment` (BR-017) | Ngày hiệu lực phải nằm trong thời gian làm việc của nhân viên. |
| `assignment_same_date` (EC-002) | Đã có thay đổi công tác cùng ngày hiệu lực. Sửa thay đổi đó thay vì thêm mới. |
| `reason_required` | Hãy nhập lý do. |
| `termination_before_hire` (EC-087) | Ngày làm việc cuối cùng không được trước ngày vào làm. |
| `assignment_after_termination` (EC-009) | Còn thay đổi công tác có hiệu lực sau ngày làm việc cuối cùng. Hủy các thay đổi đó trước. |
| `termination_already_effective` (BR-020) | Ngày làm việc cuối cùng đã qua nên không hủy được việc nghỉ việc. |
| `contract_overlap` (BR-025) | Hợp đồng chồng thời gian với hợp đồng [số hợp đồng]. Sửa ngày kết thúc của hợp đồng đó trước. |
| `contract_term_invalid` (BR-024, BR-028) | Thời hạn hợp đồng vượt mức tối đa [số] của loại hợp đồng này. |
| `contract_number_taken` (BR-037) | Số hợp đồng đã tồn tại. |
| `leave_type_annual_locked` (BR-041) | Không thể ngừng dùng hay đổi chế độ của loại Phép năm. |
| `calendar_day_conflict` | Ngày này đã được khai báo. |
| `leave_no_working_days` (BR-044) | Khoảng ngày bạn chọn không có ngày làm việc nào. |
| `leave_overlap` (BR-045) | Bạn đã có đơn nghỉ khác trong khoảng thời gian này. |
| `leave_insufficient_balance` (BR-053) | Bạn còn [số] ngày phép, không đủ cho đơn [số] ngày. |
| `leave_exceeds_type_max` (BR-047) | Loại nghỉ này tối đa [số] ngày mỗi đơn. |
| `leave_outside_employment` (BR-046) | Ngày nghỉ phải nằm trong thời gian làm việc. |
| `leave_backdate_exceeded` (BR-062) | Chỉ gửi được đơn cho ngày đã qua trong vòng [số] ngày. Nhờ HR ghi đơn thay. |
| `leave_not_cancellable` (BR-061) | Đơn đã bắt đầu nên bạn không tự hủy được. Nhờ HR hủy hoặc rút ngắn. |
| `self_approval` (BR-060) | Bạn không thể tự duyệt đơn của mình. |
| `internal_error` | Có lỗi xảy ra. Thử lại sau ít phút; nếu vẫn lỗi, gửi mã [traceId] cho HR. |
| Gửi đơn thành công | Đã gửi đơn. [Tên người duyệt] sẽ nhận được thông báo. |
| Duyệt đơn thành công | Đã duyệt đơn của [họ tên]. |
| Tạo tài khoản, đặt lại mật khẩu | Mật khẩu tạm: [mật khẩu]. Mật khẩu này chỉ hiện một lần; hãy gửi riêng cho nhân viên. |
