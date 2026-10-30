# Questions and assumptions

- **Updated:** 2026-10-30

> Ghi mọi điều chưa biết ở đây, kể cả câu tự hỏi mình. Câu trả lời từ người dùng, tài liệu hay thử nghiệm được chép vào
> đây, kèm nguồn và ngày. Nhiều người cần hỏi cùng một câu thì gửi kèm mã `Q-xxx` để dễ đối chiếu.

## Questions

- **Priority:** `blocks-design` (chưa có trả lời thì chưa thiết kế được phần liên quan), `blocks-build` (cần trước khi
  code phần liên quan), `nice-to-know` (không chặn việc gì).
- **Status:** `Open` → `Asked` → `Answered`, hoặc `Assumed` khi đã chuyển thành assumption.

| ID | Question | Why it matters | Priority | Ask | Status | Answer (source, date) |
|---|---|---|---|---|---|---|
| Q-001 | Chỗ đau lớn nhất của HR ở công ty mục tiêu là gì: nghỉ phép, chấm công, lương hay hồ sơ? | Xác nhận Problem của brief và milestone đầu tiên công ty dùng được | blocks-design | HR công ty mục tiêu | Assumed | Xem A-001 |
| Q-002 | Hiện nay công ty xin nghỉ, duyệt nghỉ và theo dõi số dư phép bằng cách nào, và mất bao lâu? | Hiện trạng trong brief; luồng duyệt; giá trị baseline của success metrics | blocks-design | HR công ty mục tiêu | Assumed | Xem A-002 |
| Q-003 | Công ty có bao nhiêu nhân viên, bao nhiêu phòng ban và mấy cấp quản lý? | Cơ cấu tổ chức, phân quyền và quality attribute về tải | blocks-design | HR công ty mục tiêu | Assumed | Xem A-011. Chủ dự án chọn quy mô thiết kế tới 300 nhân viên, 2026-10-30 |
| Q-004 | Quy chế nghỉ phép của công ty khác Bộ luật Lao động ở đâu: số ngày phép, cộng dồn sang năm sau, nghỉ nửa ngày, cấp duyệt? | Business rule của M2 | blocks-design | HR công ty mục tiêu | Assumed | Xem A-012 |
| Q-005 | Công ty chấm công bằng gì: máy chấm công, app hay bảng tính? Hệ thống có phải nhập dữ liệu từ máy chấm công không? | Hệ thống ngoài và luồng dữ liệu của M3 | blocks-design | HR công ty mục tiêu | Assumed | Xem A-006 |
| Q-006 | Công ty tính lương thế nào: gồm những khoản lương và phụ cấp nào, ai tính BHXH và thuế TNCN, trả lương ngày nào? | Phạm vi và business rule của M4 | blocks-design | HR hoặc kế toán công ty mục tiêu | Assumed | Xem A-009. Chủ dự án chọn HR tính lương, 2026-10-30 |
| Q-007 | Ban giám đốc cần những báo cáo nào, và xem bao lâu một lần? | Phạm vi của M5 | blocks-design | Ban giám đốc công ty mục tiêu | Assumed | Xem A-010. Chủ dự án chọn để Quản lý xem chi phí lương tổng hợp, 2026-10-30 |
| Q-008 | Số hiệu, mức giảm trừ gia cảnh và biểu thuế của Luật Thuế TNCN sửa đổi là gì? Tỷ lệ đóng BHYT, BHTN và lương tối thiểu vùng đang hiệu lực là bao nhiêu? | Nguồn của business rule ở M4, xem [research](research.md#legal-sources) | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Assumed | Xem A-013 |
| Q-009 | Ngân sách hạ tầng mỗi tháng là bao nhiêu? | Chọn hosting ở Phase 3 | blocks-design | Chủ dự án, khi so sánh chi phí trong ADR hosting ở Phase 3 | Answered | Khoảng $10–25 mỗi tháng; chi tiết ở ADR-0005. Chủ dự án, 2026-10-30 |
| Q-010 | Công ty có đồng ý dùng thử không, và với điều kiện gì về dữ liệu nhân viên? | Thời điểm dùng dữ liệu thật; success metrics dài hạn | nice-to-know | Ban giám đốc công ty mục tiêu | Open | |
| Q-011 | Nhân viên đã nghỉ việc được tuyển lại thì dùng lại hồ sơ và mã nhân viên cũ, hay tạo hồ sơ mới? | Entity Nhân viên; luật mã nhân viên và số CCCD không trùng | blocks-design | HR công ty mục tiêu | Answered | Dùng lại hồ sơ và mã cũ (BR-139). Chủ dự án, 2026-10-30 |
| Q-012 | Công ty giữ dữ liệu cá nhân và nhật ký của nhân viên đã nghỉ việc trong bao lâu? | Thời hạn lưu trong mục Sensitive data của domain | blocks-design | HR công ty mục tiêu; Luật Bảo vệ dữ liệu cá nhân | Answered | Xóa thông tin liên hệ sau 12 tháng, ẩn danh sau 10 năm, HR xác nhận (BR-140, BR-141). Chủ dự án, 2026-10-30; con số chờ HR công ty xác nhận |
| Q-013 | Điều 20, 24 và 25 Bộ luật Lao động 2019 về loại hợp đồng, thời hạn hợp đồng và thời gian thử việc có đúng như domain đang ghi không? | Luật hợp đồng của M1 và các tham số đi kèm | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Assumed | Xem A-013 |
| Q-014 | Mọi nhân viên của công ty có email công việc không? | Tên đăng nhập và cách đặt lại mật khẩu | blocks-design | HR công ty mục tiêu | Assumed | Xem A-004 |
| Q-015 | Công ty làm việc những ngày nào trong tuần? Có làm sáng thứ Bảy không? | Cách tính số ngày nghỉ; bảng công ở M3 | blocks-design | HR công ty mục tiêu | Assumed | Xem A-005 |
| Q-016 | Quy chế phép tồn của công ty: được chuyển tối đa bao nhiêu ngày, dùng tới ngày nào? Nhân viên được gửi đơn cho ngày đã qua trong bao lâu? | Giá trị của `carryover_max_days`, `carryover_expiry`, `leave_backdate_days` | blocks-build | HR công ty mục tiêu | Open | |
| Q-017 | Điều 112 tới 115 Bộ luật Lao động 2019 và Điều 65, 66 Nghị định 145/2020/NĐ-CP về nghỉ lễ, phép năm, thâm niên, nghỉ việc riêng và tháng đủ điều kiện có đúng như domain đang ghi không? Văn bản nào hướng dẫn Bộ luật Lao động đang có hiệu lực? | Luật và tham số của M2 | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Assumed | Xem A-013 |
| Q-018 | Máy chấm công của công ty là loại nào, và xuất được file định dạng gì, gồm những cột nào? | Định dạng file nhập ở US-039 | blocks-build | HR công ty mục tiêu | Open | |
| Q-019 | Kỳ công của công ty là tháng dương lịch, hay từ một ngày giữa tháng, ví dụ 26 tháng trước tới 25 tháng này? | Cách chốt và tổng hợp bảng công | blocks-design | HR công ty mục tiêu | Assumed | Xem A-007 |
| Q-020 | Điều 105 tới 107 Bộ luật Lao động 2019 và Nghị định 145/2020/NĐ-CP về giờ làm bình thường, giờ làm ban đêm và giới hạn làm thêm có đúng như domain đang ghi không? Công ty có thuộc ngành được làm thêm tới 300 giờ mỗi năm không? | Luật và tham số của M3 | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật; HR công ty mục tiêu | Assumed | Xem A-013 |
| Q-021 | Điều 98 Bộ luật Lao động 2019 và Điều 55, 57, 67 Nghị định 145/2020/NĐ-CP về đơn giá giờ, hệ số làm thêm, làm ban đêm và lương làm căn cứ trả phép chưa nghỉ có đúng như domain đang ghi không? Hệ số làm thêm ban đêm có khác khi ban ngày không làm thêm không? | Luật BR-107, BR-108, BR-109, BR-120 | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Assumed | Xem A-013 |
| Q-022 | Công ty đặt ở địa bàn thuộc vùng lương tối thiểu nào? Có chi nhánh ở vùng khác không? | Giá trị `company_region`; mức sàn lương và trần BHTN | blocks-build | HR công ty mục tiêu | Assumed | Xem A-008 |
| Q-023 | Luật Bảo hiểm xã hội 2024 và văn bản hướng dẫn quy định thế nào về đối tượng đóng với hợp đồng thử việc, ngưỡng 14 ngày không đóng và trần mức đóng? Sau khi Luật Thuế TNCN sửa đổi có hiệu lực, mức khấu trừ 10% với hợp đồng dưới 3 tháng và mức miễn thuế tiền ăn giữa ca còn đúng không? | Luật BR-100, BR-101, BR-110, BR-111, BR-113 và loại phụ cấp mặc định | blocks-design | Cơ sở dữ liệu quốc gia về văn bản pháp luật | Assumed | Xem A-013 |

## Assumptions

Câu hỏi chưa có trả lời mà vẫn phải làm tiếp thì ghi thành assumption, kèm cách kiểm và hậu quả nếu sai. Assumption là
con số thì đặt trong config.

| ID | From | Assumption | Impact if wrong | Check by | Confirmed |
|---|---|---|---|---|---|
| A-001 | Q-001 | Chỗ đau lớn nhất là xin và duyệt nghỉ đang rời rạc | Viết lại Problem của brief; bản đầu tiên công ty dùng được không còn là M2 | Hỏi HR công ty trước khi requirements `Accepted` | No |
| A-002 | Q-002 | Nhân viên xin nghỉ qua Zalo hoặc nói miệng; quản lý duyệt miệng; HR theo dõi số dư phép bằng bảng tính | Sửa Users và Alternatives của brief; sửa luồng duyệt trong requirements | Hỏi HR công ty trước khi requirements `Accepted` | No |
| A-003 | — | Các luật nghiệp vụ ghi nguồn A-003 trong domain do agent đề xuất theo cách làm phổ biến ở doanh nghiệp nhỏ | Sửa luật, story liên quan và có thể cả data model | Chủ dự án rà khi review domain; HR công ty rà khi có buổi trao đổi | No |
| A-004 | Q-014 | Không phải ai cũng có email công việc, nên tên đăng nhập là mã nhân viên và HR đặt lại mật khẩu | Đổi luật tài khoản, màn hình đăng nhập và có thể thêm tự đặt lại mật khẩu qua email | Hỏi HR công ty | No |
| A-005 | Q-015 | Ca mặc định của công ty làm từ thứ Hai tới thứ Sáu, cả ngày | Đổi `default_shift`; nếu có làm nửa ngày thứ Bảy thì ca cần khai báo giờ làm riêng cho từng ngày trong tuần | Hỏi HR công ty | No |
| A-006 | Q-005 | Công ty có máy chấm công xuất được file gồm mã chấm công và thời điểm chấm; HR nhập file định kỳ | Đổi cách lấy dữ liệu chấm công ở M3 | Hỏi HR công ty | No |
| A-007 | Q-019 | Kỳ công là tháng dương lịch | Đổi cách xác định kỳ công, cách chốt và tổng hợp bảng công | Hỏi HR công ty | No |
| A-008 | Q-022 | Công ty chỉ có một địa điểm, thuộc vùng I | Lương tối thiểu vùng phải gắn với nơi làm việc của từng nhân viên thay vì cả công ty | Hỏi HR công ty | No |
| A-009 | Q-006 | Công ty trả lương mỗi tháng một lần sau khi chốt công; phụ cấp gồm ăn giữa ca, trách nhiệm, điện thoại, đi lại | Thêm kỳ trả lương giữa tháng; đổi loại phụ cấp mặc định | Hỏi HR hoặc kế toán công ty | No |
| A-010 | Q-007 | Ban giám đốc xem hằng tháng năm báo cáo cố định: biến động nhân sự, cơ cấu nhân sự, nghỉ phép, chấm công và chi phí lương | Thêm hoặc bỏ báo cáo; nếu cần báo cáo tự tạo thì đổi phạm vi M5 | Hỏi ban giám đốc công ty | No |
| A-011 | Q-003 | Công ty có tới 300 nhân viên, khoảng 30 phòng ban, tối đa 5 cấp | Đổi số đo của QA-004; trên 1.000 nhân viên thì tính lương và nhập file có thể phải chạy nền | Hỏi HR công ty | No |
| A-012 | Q-004 | Quy chế nghỉ phép của công ty theo Bộ luật Lao động; phần khác luật nằm trong tham số của M2 và loại nghỉ cấu hình được | Thêm luật hoặc tham số cho phần quy chế khác luật | Hỏi HR công ty | No |
| A-013 | Q-008, Q-013, Q-017, Q-020, Q-021, Q-023 | Luật và giá trị lấy từ văn bản pháp luật đang ghi trong domain là đúng. Mọi tỷ lệ, mức tiền và giới hạn đã là tham số | Sửa giá trị tham số; nếu cách tính khác thì sửa luật, story và test liên quan | Đối chiếu văn bản gốc trước khi code milestone dùng luật đó | No |
