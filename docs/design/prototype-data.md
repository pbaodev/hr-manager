# Prototype data: hr-manager

- **Status:** Draft
- **Updated:** 2026-11-01
- **Reviewed:** [YYYY-MM-DD: AI review ở PR; chủ dự án duyệt]
- **Related:** [prototype](prototype.md) · [domain](../analysis/domain.md) · [stories](../analysis/stories.md)

Bộ dữ liệu giả cho canvas prototype, theo mục Mock data của [prototype](prototype.md). Mọi con số trên canvas lấy từ
file này. Tên, mã nhân viên, số tiền và mọi dữ liệu khác đều là giả; số CCCD và số tài khoản ngân hàng chỉ hiện dạng
che, ví dụ `•••• 4821`. Tham số dùng giá trị ở mục Parameters của [domain](../analysis/domain.md#parameters), trừ các
chỗ ghi ở mục Settings. Tiền lương tính theo BR-103 tới BR-114, làm tròn từng dòng tới đồng.

## Company

| Department | Parent | Head | Headcount 1/8/2026 | Headcount 9/11/2026 | Note |
|---|---|---|---|---|---|
| Công ty Mẫu | — | Nguyễn Minh Quân | 1 | 1 | Phòng ban gốc |
| Kinh doanh | Công ty Mẫu | Lê Văn Hùng | 15 | 15 | Ngưỡng nhân sự riêng 70% (US-075 AC4). Ra 3, vào 3 trong tháng 8 tới 10 |
| Kho vận | Công ty Mẫu | Hồ Thị Thu | 8 | 10 | Vào 2 người ngày 1/9 |
| Kỹ thuật | Công ty Mẫu | Lê Quang Minh | 8 | 8 | |
| Kế toán | Công ty Mẫu | Trương Thị Hồng | 4 | 4 | |
| Hành chính – Nhân sự | Công ty Mẫu | Đoàn Thị Lan Anh | 3 | 3 | Đoàn Thị Lan Anh và Phạm Thu Hà có vai trò HR |
| Pháp chế | Công ty Mẫu | — | 2 | 2 | Không có trưởng; quản lý trực tiếp là giám đốc (BR-012). Dưới `report_min_group_size` |
| **Total** | | | **41** | **43** | |

## Personas

| Persona | Code | Role | Login sees |
|---|---|---|---|
| Trần Thị Mai | NV00026 | Nhân viên | Dữ liệu của mình |
| Lê Văn Hùng | NV00004 | Quản lý | Phạm vi phòng Kinh doanh, 15 người |
| Phạm Thu Hà | NV00017 | HR | Mọi người |
| Nguyễn Minh Quân | NV00001 | Quản lý | Phạm vi toàn công ty, 43 người |

## Employees

46 người: 43 người đang làm ngày 9/11/2026 và 3 người đã nghỉ việc trong tháng 8 tới 10. Mã cấp theo ngày vào làm
(BR-015). Mọi người có số tài khoản ngân hàng giả, trừ Đinh Văn Quý. Lương và phụ cấp là số tháng; Ăn giữa ca tính
theo công, các phụ cấp khác cố định theo tháng.

| Code | Name | Department | Title | Hire date | Last day | Contract | Base salary | Insurance salary | Allowances | Dependents |
|---|---|---|---|---|---|---|---|---|---|---|
| NV00001 | Nguyễn Minh Quân | Công ty Mẫu | Giám đốc | 1/3/2015 | — | Không xác định thời hạn | 45.000.000 | 45.000.000 | Ăn giữa ca 730.000; Trách nhiệm 5.000.000 | 2 |
| NV00002 | Trương Thị Hồng | Kế toán | Kế toán trưởng | 1/3/2015 | — | Không xác định thời hạn | 22.000.000 | 22.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 1 |
| NV00003 | Đoàn Thị Lan Anh | Hành chính – Nhân sự | Trưởng phòng Hành chính – Nhân sự | 1/3/2015 | — | Không xác định thời hạn | 20.000.000 | 20.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 1 |
| NV00004 | Lê Văn Hùng | Kinh doanh | Trưởng phòng Kinh doanh | 1/6/2017 | — | Không xác định thời hạn | 28.000.000 | 28.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000; Điện thoại 300.000 | 1 |
| NV00005 | Hồ Thị Thu | Kho vận | Trưởng kho | 1/3/2018 | — | Không xác định thời hạn | 18.000.000 | 18.000.000 | Ăn giữa ca 730.000; Trách nhiệm 2.000.000 | 0 |
| NV00006 | Lê Quang Minh | Kỹ thuật | Trưởng phòng Kỹ thuật | 1/8/2018 | — | Không xác định thời hạn | 25.000.000 | 25.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 2 |
| NV00007 | Trần Văn Thắng | Kỹ thuật | Kỹ sư | 3/6/2019 | — | Không xác định thời hạn | 20.000.000 | 20.000.000 | Ăn giữa ca 730.000 | 1 |
| NV00008 | Phí Thị Loan | Kế toán | Kế toán viên | 1/7/2019 | — | Không xác định thời hạn | 13.000.000 | 13.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00009 | Đặng Minh Tuấn | Kinh doanh | Nhân viên kinh doanh | 2/9/2019 | — | Không xác định thời hạn | 14.000.000 | 14.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00010 | Thái Văn Lộc | Kho vận | Lái xe | 4/5/2020 | — | Không xác định thời hạn | 9.000.000 | 9.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00011 | Nghiêm Văn Thành | Pháp chế | Chuyên viên pháp chế | 1/7/2020 | — | Không xác định thời hạn | 18.000.000 | 18.000.000 | Ăn giữa ca 730.000 | 1 |
| NV00012 | Bùi Thị Hoa | Kinh doanh | Nhân viên kinh doanh | 3/8/2020 | — | Không xác định thời hạn | 13.000.000 | 13.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00013 | Cao Văn Dũng | Kinh doanh | Nhân viên kinh doanh | 1/10/2020 | 31/8/2026 | Không xác định thời hạn | 12.000.000 | 12.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00014 | Nguyễn Thị Phương | Kỹ thuật | Kỹ sư | 1/2/2021 | — | Không xác định thời hạn | 18.000.000 | 18.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00015 | Ngô Thị Thảo | Kinh doanh | Nhân viên kinh doanh | 10/5/2021 | — | Không xác định thời hạn | 11.500.000 | 11.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00016 | Châu Văn Lực | Kho vận | Nhân viên kho | 1/6/2021 | — | Không xác định thời hạn | 8.000.000 | 8.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00017 | Phạm Thu Hà | Hành chính – Nhân sự | Chuyên viên nhân sự | 2/8/2021 | — | Không xác định thời hạn | 14.000.000 | 14.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00018 | Tôn Nữ Hạnh | Kinh doanh | Nhân viên kinh doanh | 1/11/2021 | 30/9/2026 | Không xác định thời hạn | 11.000.000 | 11.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00019 | Vũ Đức Long | Kinh doanh | Nhân viên kinh doanh | 4/1/2022 | — | Không xác định thời hạn | 11.000.000 | 11.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00020 | Hồ Văn Sơn | Kho vận | Nhân viên kho | 1/3/2022 | — | Không xác định thời hạn | 7.500.000 | 7.500.000 | Ăn giữa ca 730.000 | 0 |
| NV00021 | Lục Thị Diệu | Hành chính – Nhân sự | Nhân viên hành chính | 4/5/2022 | — | Không xác định thời hạn | 9.000.000 | 9.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00022 | Tạ Văn Hải | Kho vận | Nhân viên kho | 5/9/2022 | — | Không xác định thời hạn | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00023 | Ông Văn Tài | Kế toán | Kế toán viên | 3/10/2022 | — | Không xác định thời hạn | 12.000.000 | 12.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00024 | Trịnh Văn Khoa | Kinh doanh | Nhân viên kinh doanh | 1/11/2022 | — | Không xác định thời hạn | 11.000.000 | 11.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00025 | Vương Thị Nhung | Kỹ thuật | Kỹ sư | 1/3/2023 | — | Không xác định thời hạn | 15.000.000 | 15.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00026 | Trần Thị Mai | Kinh doanh | Nhân viên kinh doanh | 15/3/2023 | — | Không xác định thời hạn | 12.000.000; 12.500.000 từ 1/9/2026 | 12.000.000; 12.500.000 từ 1/9/2026 | Ăn giữa ca 730.000; Điện thoại 300.000; Đi lại 500.000 tới 31/8/2026 | 0 |
| NV00027 | Lâm Thị Nga | Kho vận | Nhân viên kho | 3/4/2023 | — | Không xác định thời hạn | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00028 | Lý Văn Phúc | Kinh doanh | Nhân viên kinh doanh | 6/6/2023 | — | Không xác định thời hạn | 10.500.000 | 10.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00029 | Đàm Văn Hưng | Kỹ thuật | Kỹ thuật viên | 4/9/2023 | — | Không xác định thời hạn | 12.000.000 | 12.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00030 | Âu Minh Trí | Kinh doanh | Nhân viên kinh doanh | 2/10/2023 | 15/10/2026 | Không xác định thời hạn | 10.500.000 | 10.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00031 | Khúc Thị Vân | Kế toán | Thủ quỹ | 1/2/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00032 | Quan Thị My | Pháp chế | Chuyên viên pháp chế | 4/3/2024 | — | Không xác định thời hạn | 14.000.000 | 14.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00033 | Hoàng Thị Yến | Kinh doanh | Nhân viên kinh doanh | 1/4/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00034 | Kiều Văn Tâm | Kho vận | Nhân viên kho | 1/7/2024 | — | Không xác định thời hạn | 5.400.000 | 5.400.000 | Ăn giữa ca 730.000 | 0 |
| NV00035 | Phạm Văn Cường | Kinh doanh | Nhân viên kinh doanh | 15/7/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00036 | Lương Văn Bình | Kho vận | Nhân viên kho | 1/10/2024 | — | Không xác định thời hạn | 6.000.000 | 5.310.000 | Ăn giữa ca 730.000 | 0 |
| NV00037 | Mạc Văn Toàn | Kỹ thuật | Kỹ sư | 2/12/2024 | — | Xác định thời hạn 2/12/2024–30/11/2026 | 16.000.000 | 16.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00038 | Đỗ Thị Hằng | Kinh doanh | Nhân viên kinh doanh | 2/12/2024 | — | Không xác định thời hạn | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00039 | Mai Văn Đức | Kinh doanh | Nhân viên kinh doanh | 3/2/2025 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00040 | Hà Thị Bích | Kỹ thuật | Kỹ thuật viên | 1/4/2025 | — | Không xác định thời hạn | 11.000.000 | 11.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00041 | La Văn Khánh | Kỹ thuật | Kỹ sư | 5/1/2026 | — | Xác định thời hạn 12 tháng từ 5/1/2026 | 15.000.000 | 15.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00042 | Phùng Văn Hiếu | Kinh doanh | Nhân viên kinh doanh | 1/9/2026 | — | Thử việc tới 31/10/2026, rồi xác định thời hạn 12 tháng | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00043 | Đinh Văn Quý | Kho vận | Nhân viên kho | 1/9/2026 | — | Thử việc tới 31/10/2026, rồi xác định thời hạn 12 tháng | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00044 | Mã Văn Kiên | Kho vận | Nhân viên kho | 1/9/2026 | — | Thử việc tới 31/10/2026, rồi xác định thời hạn 12 tháng | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00045 | Phan Thị Ngọc | Kinh doanh | Nhân viên kinh doanh | 1/10/2026 | — | Thử việc tới 30/11/2026 | Chưa có bản ghi lương | — | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00046 | Dương Quốc Việt | Kinh doanh | Nhân viên kinh doanh | 1/10/2026 | — | Thử việc tới 30/11/2026 | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |

## Settings

Giá trị khác mặc định của domain, hoặc dữ liệu cấu hình mà prototype cần.

| Setting | Value | Used by |
|---|---|---|
| `attendance_close_day` | 5 | BR-218; tình huống 11 |
| Ngưỡng nhân sự riêng của phòng Kinh doanh | 70% | BR-146; tình huống 4, 9 |
| Ngày nghỉ lễ năm 2026, giả định | 1/1; 16/2 tới 20/2; 27/4, nghỉ bù Giỗ Tổ; 30/4; 1/5; 1/9; 2/9 | BR-038 |
| Giai đoạn hạn chế nghỉ | "Cao điểm cuối năm", 23/11 tới 31/12/2026, phòng Kinh doanh và Kho vận, ghi chú "Ưu tiên giữ đủ người giao hàng và chốt doanh số cuối năm" | BR-147, BR-171 |
| Lương tối thiểu vùng I, giá trị mới HR thêm ngày 9/11 | 5.600.000 từ 01/01/2027, giả định | BR-219; tình huống 15 |

Ngày làm việc theo `default_shift`: tháng 8/2026 có 21 ngày, tháng 9 có 20 ngày vì nghỉ 1/9 và 2/9, tháng 10 có 22
ngày, tháng 11 có 21 ngày.

## Leave

**Số dư phép năm của Mai ngày 9/11/2026** (phép năm cơ bản 12 ngày, cộng 1 ngày mỗi tháng):

| Date | Entry | Days | Balance |
|---|---|---|---|
| 1/1/2026 | Chuyển phép tồn từ 2025 | +3,0 | 3,0 |
| 31/1 tới 31/10/2026 | Cộng phép 10 tháng | +10,0 | 13,0 |
| 12/3/2026 | Sử dụng 12/3 tới 13/3, trừ vào phép tồn | −2,0 | 11,0 |
| 1/4/2026 | Hủy phép tồn hết hạn | −1,0 | 10,0 |
| 14/8/2026 | Sử dụng 14/8 | −1,0 | 9,0 |
| 30/10/2026 | Sử dụng 20/11, đơn đã duyệt | −1,0 | 8,0 |

**Leave requests** của phòng Kinh doanh và Kỹ thuật dùng trong các tình huống:

| Employee | Dates | Type and reason | Status on 9/11 | Situation |
|---|---|---|---|---|
| Trần Thị Mai | 20/11 | Phép năm; Nghỉ ngơi, việc cá nhân | Đã duyệt 30/10 | 5 |
| Trần Thị Mai | Chiều 13/11 tới hết 16/11, 1,5 ngày | Phép năm; Anh chị em ruột kết hôn | Gửi ngày 9/11 | 1, 2 |
| Vũ Đức Long | 17/11 tới 19/11, 3 ngày | Phép năm; Nghỉ ngơi, việc cá nhân | Chờ duyệt từ 2/11. Ngày 5/11 HR điều chỉnh −1,0 ngày với lý do "Sửa số dư đầu kỳ nhập thừa", nên số phép còn 2,0 | 3 |
| Đặng Minh Tuấn, Hoàng Thị Yến | 12/11, cả ngày | Phép năm | Đã duyệt | 4 |
| Phạm Văn Cường, Đỗ Thị Hằng | Sáng 12/11 | Phép năm | Đã duyệt | 4 |
| Ngô Thị Thảo | Sáng 12/11 | Phép năm; Nghỉ ngơi, việc cá nhân | Gửi lúc 8:45 ngày 9/11; mức phủ sáng 12/11 còn 10/15 | 4 |
| Bùi Thị Hoa | 26/11 tới 27/11 | Phép năm; Nghỉ ngơi, việc cá nhân | Gửi 5/11. Hùng đề nghị 19/11 tới 20/11 ngày 6/11, lời nhắn "Cuối tháng phòng vào cao điểm, em đổi sang 19 và 20/11 được không?". Hoa không đồng ý, phản hồi "Em đã đặt vé đi đám cưới bạn ngày 26/11". Đơn về Chờ duyệt | 6 |
| Trịnh Văn Khoa | 1/12 | Phép năm; Nghỉ ngơi, việc cá nhân | Chờ duyệt từ 3/11, tới 9/11 là 4 ngày làm việc | 7 |
| Đặng Minh Tuấn, Hoàng Thị Yến, Mai Văn Đức | 24/12, cả ngày | Phép năm | Đã duyệt | 9 |
| Lý Văn Phúc, Phạm Văn Cường | Chiều 24/12 | Phép năm | Chờ duyệt; chiều 24/12 phòng còn 10/15 | 9 |
| La Văn Khánh | 7/12 tới 9/12 và 10/12 tới 11/12 | Kết hôn 3 ngày, Phép năm 2 ngày; Bản thân kết hôn | Gửi trong một lần ngày 9/11 | 8 |

## Attendance

- **Tháng 10/2026:** đã nhập đủ chấm công, chưa chốt. Việc còn chặn (BR-089):
  - Giải trình của Lý Văn Phúc cho 28/10, gửi 30/10, chờ Lê Văn Hùng.
  - Giải trình của Hồ Văn Sơn cho 29/10, gửi 30/10, chờ Hồ Thị Thu.
  - Tạ Văn Hải, 26/10: Vắng chưa xử lý.
  - Lâm Thị Nga, 27/10: Thiếu chấm công.
  - Mạc Văn Toàn, 30/10: Thiếu chấm công.
  - Ngày 4/11, một ngày làm việc trước hạn 5/11, HR đã được báo về hai giải trình còn chờ (BR-218).
- **Tháng 11/2026:** HR nhập file từ 1/11 tới 6/11 lúc 8:30 ngày 9/11, 1.204 dòng, 6 dòng trùng, 2 dòng có mã chấm công
  không khớp. Ba người được báo ngày chưa xử lý (BR-216):
  - Trần Thị Mai, 3/11: Thiếu chấm công; giờ vào 7:58, không có giờ ra.
  - Tạ Văn Hải, 4/11: Vắng chưa xử lý.
  - Hoàng Thị Yến, 5/11: Thiếu chấm công.
- **Làm thêm tháng 11 của Châu Văn Lực:**
  - Đã duyệt 36 giờ: 1/11, chủ nhật, 8 giờ; 2/11 tới 6/11, mỗi ngày 17:30–21:30, 20 giờ; 7/11, thứ bảy, 8 giờ.
  - Đang chờ 2 giờ: 10/11, 17:30–19:30.
  - Ngày 9/11 lúc 15:00, Lực đăng ký 11/11, 17:30–20:30, 3 giờ. Đơn bị từ chối vì tổng 41 giờ vượt 40 giờ; Lực còn
    được làm 2 giờ (tình huống 12).
  - Cả năm 2026, Lực đã có 186 giờ làm thêm đã duyệt và đang chờ, dưới giới hạn 200 giờ.
  - Hồ Văn Sơn đã duyệt 33 giờ trong tháng 11.
- **Đi muộn của phòng Kho vận:** tháng 6, 7, 8/2026 lần lượt 9, 10, 11 lần, khi phòng có 8 người. Tháng 9 là 18 lần,
  khi phòng có 10 người. Bình quân mỗi người tăng từ 1,25 lên 1,8 lần, tức tăng 44%; tổng số lần tăng 8.

## Payroll

**Phiếu lương của Mai**, tháng 8 và tháng 9/2026 đã chốt (tình huống 14). Mai không có người phụ thuộc. Tháng 9, Mai
có bản ghi lương mới từ 1/9 với lý do "Điều chỉnh lương sau đánh giá, bỏ phụ cấp đi lại". Tháng 9 cũng có khoản truy
lĩnh hoa hồng tháng 8.

| Line | 8/2026 | 9/2026 | Change |
|---|---|---|---|
| Công chuẩn | 21 | 20 | −1 |
| Công hưởng lương | 21 | 20 | −1 |
| Lương theo công | 12.000.000 | 12.500.000 | +500.000 |
| Ăn giữa ca | 730.000 | 730.000 | 0 |
| Điện thoại | 300.000 | 300.000 | 0 |
| Đi lại | 500.000 | không có | không còn |
| Tổng thu nhập | 13.530.000 | 13.530.000 | 0 |
| BHXH 8% | 960.000 | 1.000.000 | +40.000 |
| BHYT 1,5% | 180.000 | 187.500 | +7.500 |
| BHTN 1% | 120.000 | 125.000 | +5.000 |
| Thu nhập chịu thuế | 12.800.000 | 14.300.000 | +1.500.000 |
| Thu nhập tính thuế | 0, vì −3.960.000 âm | 0, vì −2.512.500 âm | — |
| Thuế TNCN | 0 | 0 | 0 |
| Truy lĩnh hoa hồng tháng 8, chịu thuế | không có | 1.500.000 | mới |
| Thực lĩnh | 12.270.000 | 13.717.500 | +1.447.500 |
| Công ty đóng BHXH 17,5% | 2.100.000 | 2.187.500 | +87.500 |
| Công ty đóng BHYT 3% | 360.000 | 375.000 | +15.000 |
| Công ty đóng BHTN 1% | 120.000 | 125.000 | +5.000 |
| Kinh phí công đoàn 2% | 240.000 | 250.000 | +10.000 |

**Bảng lương theo phòng ban.** Chi phí lương tính theo BR-131: tổng thu nhập, cộng khoản điều chỉnh, cộng phần công ty
đóng.

| Department | 8/2026 | 9/2026 | 10/2026, side point 12/11 |
|---|---|---|---|
| Công ty Mẫu, giám đốc | 61.305.000 | 61.305.000 | 61.305.000 |
| Kinh doanh | 246.190.000 | 242.487.500 | 231.137.500, chưa gồm Phan Thị Ngọc |
| Kho vận | 96.707.564 | 117.603.100 | 116.877.305 |
| Kỹ thuật | 171.860.000 | 171.860.000 | 171.860.000 |
| Kế toán | 76.315.000 | 76.315.000 | 76.315.000 |
| Hành chính – Nhân sự | 58.295.000 | 58.295.000 | 58.295.000 |
| Pháp chế | 40.980.000 | 40.980.000 | 40.980.000 |
| **Total** | **751.652.564** | **768.845.600** | **756.769.805** |
| Số phiếu | 41 | 43 | 44 |

- **Kho vận, tháng 9 so với tháng 8:** tăng 20.895.536 đồng, tức 21,6%. Phân rã: người vào mới, Đinh Văn Quý và Mã Văn
  Kiên, +16.772.500; làm thêm của người cũ +4.123.036; thay đổi lương, phụ cấp, khoản điều chỉnh và phần công ty đóng
  đều bằng 0. Tháng 9/2025 phòng Kho vận có 8 người và chi phí 92.400.000. Cả công ty chỉ tăng 2,3%, dưới
  `payroll_change_ratio`, nên chỉ phòng Kho vận có tín hiệu (tình huống 17).
- **Phòng Pháp chế khi Quân xem chi phí lương (tình huống 18):** Pháp chế có 2 người nên được gộp vào phòng ban gốc
  (BR-129). Quân thấy dòng "Công ty Mẫu và Pháp chế, 3 người" với 102.285.000 đồng của tháng 9.
- **Bảng lương tháng 10, side point 12/11 (tình huống 13):** bảng công tháng 10 đã chốt và bảng lương ở trạng thái Nháp.
  - Lỗi: Phan Thị Ngọc chưa có bản ghi lương (BR-117).
  - Cảnh báo: Đinh Văn Quý thiếu số tài khoản ngân hàng (BR-126).
  - HR ghi bản ghi lương 9.500.000 từ 1/10 cho Ngọc, bảng lương sang Cần tính lại (BR-119). Tính lại thì Ngọc có phiếu
    và hết lỗi.
- **Lương tối thiểu vùng mới (tình huống 15):** HR thêm vùng I 5.600.000 từ 01/01/2027. Danh sách dưới mức sàn có hai
  người:
  - Kiều Văn Tâm: lương cơ bản và lương đóng bảo hiểm 5.400.000, thấp hơn 200.000. Tâm đã có bản ghi lương 5.800.000 từ
    01/03/2027, nên khoảng bị ảnh hưởng là 01/01/2027 tới 28/02/2027.
  - Lương Văn Bình: lương đóng bảo hiểm 5.310.000, thấp hơn 290.000, từ 01/01/2027.

## History

Số tổng hợp theo tháng, đã chốt công và lương. Không có số của từng người.

| Month | Headcount at month end | Leavers | Company payroll cost | Kho vận payroll cost | Kho vận late arrivals |
|---|---|---|---|---|---|
| 9/2025 | 40 | 0 | 712.000.000 | 92.400.000 | 8 |
| 10/2025 | 40 | 0 | 716.500.000 | 93.100.000 | 9 |
| 11/2025 | 40 | 0 | 721.000.000 | 95.800.000 | 10 |
| 12/2025 | 40 | 0 | 735.000.000 | 97.200.000 | 12 |
| 1/2026 | 41 | 0 | 742.300.000 | 94.000.000 | 9 |
| 2/2026 | 41 | 0 | 739.800.000 | 90.500.000 | 7 |
| 3/2026 | 41 | 0 | 744.100.000 | 95.300.000 | 8 |
| 4/2026 | 41 | 0 | 745.600.000 | 95.900.000 | 9 |
| 5/2026 | 41 | 0 | 746.900.000 | 96.100.000 | 10 |
| 6/2026 | 41 | 0 | 748.200.000 | 96.300.000 | 9 |
| 7/2026 | 41 | 0 | 749.500.000 | 96.500.000 | 10 |

La Văn Khánh vào làm ngày 5/1/2026, nên số người tăng từ 40 lên 41.

## Signals on 9/11/2026

Tính lúc 0:00 ngày 9/11 theo mục Default signal types của [domain](../analysis/domain.md#default-signal-types).

| Signal | Scope | Severity | Personas who see it | Numbers |
|---|---|---|---|---|
| Nghỉ việc tăng | Kinh doanh | Cao | Hùng, Quân, Hà | 3 người nghỉ việc trong tháng 8 tới 10: Cao Văn Dũng 31/8, Tôn Nữ Hạnh 30/9, Âu Minh Trí 15/10. Tỷ lệ 20% so với 7,1% của cả công ty |
| Đơn chờ quá hạn | Kinh doanh | Thường | Hùng, Hà | 2 đơn chờ quá 2 ngày làm việc: Vũ Đức Long, Trịnh Văn Khoa |
| Chi phí lương đổi lớn | Kho vận | Cao | Quân, Hà | Tháng 9 tăng 21,6% so với tháng 8 |
| Vắng không lý do hoặc đi muộn tăng | Kho vận | Thường | Quân, Hà | Đi muộn tháng 9 bình quân 1,8 lần mỗi người, so với 1,25 của tháng 6 tới 8 |
| Làm thêm gần giới hạn | Kho vận | Thường | Quân, Hà | 2 người từ 80% giới hạn tháng 11: Châu Văn Lực 36 giờ, Hồ Văn Sơn 33 giờ |
| Hợp đồng sắp hết hạn | Cả công ty | Cao | Hà | Mạc Văn Toàn, hết hạn 30/11/2026, chưa có hợp đồng mới |
| Ngày chưa xử lý | Cả công ty | Cao | Hà | Tháng 10: 3 ngày của 3 người |
| Hồ sơ thiếu dữ liệu tính lương | Cả công ty | Cao | Hà | Phan Thị Ngọc thiếu bản ghi lương; Đinh Văn Quý thiếu số tài khoản |

- Lê Văn Hùng theo dõi tín hiệu Nghỉ việc tăng từ 26/10, lúc số liệu đã là 3 người và 20%. Ngày 9/11 là đủ
  `signal_follow_up_days` ngày, nên Hùng nhận nhắc kèm số liệu hiện tại (tình huống 16).
- Ngoài các tín hiệu trên, không loại nào đạt điều kiện. Tín hiệu Buổi dưới ngưỡng của sáng 12/11 chỉ xuất hiện ở lần
  tính đêm 9/11, sau khi Ngô Thị Thảo gửi đơn.
- Insight cho Quân (M6) gom ba tín hiệu của Kho vận: chi phí lương, đi muộn và làm thêm. Insight chỉ nêu chúng xảy ra
  cùng kỳ (BR-184).

**Side points 2/3 và 9/3/2027, phép tồn (tình huống 19):**

- Ngày 1/1/2027, phòng Kinh doanh có 7 người còn tổng 18 ngày phép tồn, hạn 31/3.
- Ngày 1/3, cả 7 người nhận gợi ý dùng phép tồn (BR-170). Tín hiệu Phép tồn sắp hết hạn xuất hiện; Hùng theo dõi tín
  hiệu này.
- Ngày 2/3, Hùng mở thẻ nhắc: 0 người nhận, 7 người bị bỏ vì vừa nhận gợi ý (EC-141).
- Ngày 9/3, đã qua `reminder_quiet_days`: 4 người còn tổng 10 ngày phép tồn, thẻ nhắc gửi được cho cả 4.

## Policies and questions

| Policy | Version | Effective | Sections |
|---|---|---|---|
| Nội quy lao động | 2 | 1/1/2026 | 1. Thời giờ làm việc: 8:00 tới 17:00, nghỉ trưa 12:00 tới 13:00, thứ Hai tới thứ Sáu. 2. Chấm công và giải trình: quên chấm thì gửi giải trình trước hạn chốt công ngày 5 tháng sau. 3. Làm thêm giờ: đăng ký trước khi làm, tối đa 40 giờ mỗi tháng |
| Quy chế nghỉ phép | 3, thay bản 2 có hiệu lực 1/1/2025 | 1/7/2026 | 1. Phép năm: 12 ngày, cứ 5 năm thêm 1 ngày. 2. Nghỉ việc riêng có lương và không lương theo Điều 115. 3. Thủ tục: gửi đơn trên hệ thống; quản lý trực tiếp duyệt. 4. Phép tồn: chuyển tối đa 5 ngày sang năm sau, dùng trước 31/3 |
| Quy chế lương và phúc lợi | 1 | 1/1/2026 | 1. Kỳ lương theo tháng, trả ngày 10 tháng sau. 2. Phụ cấp: ăn giữa ca 730.000; điện thoại 300.000 cho kinh doanh; trách nhiệm cho trưởng phòng. 3. Thưởng và hoa hồng: hoa hồng trả cùng lương tháng sau |

**FAQ:**

| Question | Linked section | Status |
|---|---|---|
| Quên chấm công thì làm gì? | Nội quy lao động, mục 2 | Đã đăng |
| Phép tồn dùng tới khi nào? | Quy chế nghỉ phép, mục 4 | Đã đăng, cờ cần rà lại vì quy chế có bản 3 (BR-194) |
| Khi nào nhận phiếu lương? | Quy chế lương và phúc lợi, mục 1 | Đã đăng |

**Questions to HR:**

| From | Sent | Question | Status on 9/11 |
|---|---|---|---|
| Trần Thị Mai | 2/10 | "Vì sao phiếu lương tháng 9 không còn phụ cấp đi lại?" | Đã trả lời bởi Phạm Thu Hà ngày 3/10: phụ cấp đi lại bỏ từ bản ghi lương 1/9 |
| Lâm Thị Nga | 4/11 | "Công ty có mua bảo hiểm sức khỏe cho người thân không?" | Chờ trả lời 3 ngày làm việc; mọi HR được nhắc (tình huống 20) |
| Hoàng Thị Yến | 6/11 | "Em đổi số tài khoản ngân hàng thì báo ai?" | Chờ trả lời |

**Chat scripts** (M6):

- **Tình huống 2:** Mai gõ "nghỉ chiều thứ Sáu tuần này và cả thứ Hai tuần sau, đám cưới em trai". Chat hiện phương án
  của AI Leave Coordinator: 1,5 ngày Phép năm, lý do Anh chị em ruột kết hôn; hoặc 1,5 ngày Việc riêng không lương. Chọn
  một phương án thì mở SCR-020.
- **Tình huống 5 qua chat:** Mai gõ "dời đơn ngày 20/11 sang thứ Hai". Coordinator đề xuất 23/11; SCR-020 mở ở chế độ
  Đổi đơn, kèm cảnh báo giai đoạn Cao điểm cuối năm.
- **Tình huống 21:**
  - Mai hỏi "Phép năm chưa nghỉ hết có được chuyển sang năm sau không?". Assistant trả lời: được chuyển tối đa 5 ngày,
    dùng trước 31/3. Nguồn là Quy chế nghỉ phép mục 4 và cấu hình `carryover_max_days`, `carryover_expiry`.
  - Mai hỏi "Công ty có hỗ trợ học phí tiếng Anh không?". Assistant nói không có nguồn, rồi đề nghị gửi câu hỏi cho HR.
    SCR-051 mở với câu hỏi và tóm tắt hội thoại soạn sẵn.

## Situations

Tình huống trong [prototype](prototype.md#mock-data) và nơi có dữ liệu của nó trong file này.

| # | Section |
|---|---|
| 1, 2, 5 | Leave: hai đơn của Trần Thị Mai; Chat scripts |
| 3, 4, 6, 7, 8, 9 | Leave: bảng Leave requests |
| 10, 11, 12 | Attendance |
| 13, 14, 15, 17, 18 | Payroll |
| 16, 19 | Signals on 9/11/2026 |
| 20, 21 | Policies and questions; Chat scripts |
