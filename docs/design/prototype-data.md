# Prototype data: hr-manager

- **Status:** Draft
- **Updated:** 2026-11-01
- **Reviewed:** [YYYY-MM-DD: AI review ở PR; chủ dự án duyệt]
- **Related:** [prototype](prototype.md) · [domain](../analysis/domain.md) · [stories](../analysis/stories.md)

Bộ dữ liệu giả cho canvas prototype, theo mục Mock data của [prototype](prototype.md). Mọi con số trên canvas lấy từ
file này. Tên, mã nhân viên, số tiền và mọi dữ liệu khác đều là giả; số CCCD và số tài khoản ngân hàng chỉ hiện dạng
che, ví dụ `•••• 4821`. Tham số dùng giá trị ở mục Parameters của [domain](../analysis/domain.md#parameters), trừ các
chỗ ghi ở mục Settings. Tiền lương tính theo BR-103 tới BR-114, làm tròn từng dòng tới đồng.

## Assumptions

Domain chưa nói rõ các điểm dưới đây. Dữ liệu dùng cách hiểu sau; chủ dự án chốt khi duyệt prototype.

- **Biến động Sử dụng của phép năm** ghi vào ngày nghỉ. Đơn đã duyệt mà chưa tới ngày chưa trừ vào số dư, nhưng vẫn bị
  trừ khi xét đơn mới (BR-053).
- **"3 tháng gần nhất" của tín hiệu Nghỉ việc tăng** là 3 tháng lùi từ ngày tính. Ngày 26/10/2026 là 27/7 tới 26/10;
  ngày 9/11/2026 là 10/8 tới 9/11.
- **Khoản điều chỉnh** không nằm trong tổng thu nhập, theo công thức thực lĩnh ở BR-114. Thu nhập chịu thuế bằng tổng
  thu nhập trừ phần được miễn, cộng khoản điều chỉnh chịu thuế (BR-111).
- **Phạm vi tín hiệu:** loại tính theo tỷ lệ hay bình quân (nghỉ việc, đi muộn, chi phí lương) xét từng phòng ban và cả
  công ty (BR-172). Loại tính theo người hay theo đơn (làm thêm, đơn chờ, hợp đồng, ngày chưa xử lý, hồ sơ thiếu dữ
  liệu) có một tín hiệu cấp công ty, phân rã theo phòng ban; mỗi người xem thấy phần trong phạm vi của mình.

## Company

| Department | Parent | Head | Headcount 1/8/2026 | Headcount 9/11/2026 | Note |
|---|---|---|---|---|---|
| Công ty Mẫu | — | Nguyễn Minh Quân | 1 | 1 | Phòng ban gốc |
| Kinh doanh | Công ty Mẫu | Lê Văn Hùng | 15 | 15 | Ngưỡng nhân sự riêng 70% (US-075 AC4). Ra 3, vào 3 trong tháng 8 tới 10 |
| Kho vận | Công ty Mẫu | Hồ Thị Thu | 8 | 10 | Vào 2 người ngày 3/9 |
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
(BR-015). Mọi người có số tài khoản ngân hàng giả, trừ Đinh Văn Quý. Lương và phụ cấp là số tháng và thuộc bản ghi
lương (BR-093); Ăn giữa ca tính theo công, các phụ cấp khác cố định theo tháng. Ba người nghỉ việc đã nghỉ hết phép năm
trước ngày làm việc cuối, nên phiếu lương tháng cuối của họ không có khoản trả phép chưa nghỉ (BR-120).

| Code | Name | Department | Title | Hire date | Last day | Contract | Base salary | Insurance salary | Allowances | Dependents |
|---|---|---|---|---|---|---|---|---|---|---|
| NV00001 | Nguyễn Minh Quân | Công ty Mẫu | Giám đốc | 2/3/2015 | — | Không xác định thời hạn | 45.000.000 | 45.000.000 | Ăn giữa ca 730.000; Trách nhiệm 5.000.000 | 2 |
| NV00002 | Trương Thị Hồng | Kế toán | Kế toán trưởng | 2/3/2015 | — | Không xác định thời hạn | 22.000.000 | 22.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 1 |
| NV00003 | Đoàn Thị Lan Anh | Hành chính – Nhân sự | Trưởng phòng Hành chính – Nhân sự | 2/3/2015 | — | Không xác định thời hạn | 20.000.000 | 20.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 1 |
| NV00004 | Lê Văn Hùng | Kinh doanh | Trưởng phòng Kinh doanh | 1/6/2017 | — | Không xác định thời hạn | 28.000.000 | 28.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000; Điện thoại 300.000 | 1 |
| NV00005 | Hồ Thị Thu | Kho vận | Trưởng kho | 1/3/2018 | — | Không xác định thời hạn | 18.000.000 | 18.000.000 | Ăn giữa ca 730.000; Trách nhiệm 2.000.000 | 0 |
| NV00006 | Lê Quang Minh | Kỹ thuật | Trưởng phòng Kỹ thuật | 1/8/2018 | — | Không xác định thời hạn | 25.000.000 | 25.000.000 | Ăn giữa ca 730.000; Trách nhiệm 3.000.000 | 2 |
| NV00007 | Trần Văn Thắng | Kỹ thuật | Kỹ sư | 3/6/2019 | — | Không xác định thời hạn | 20.000.000 | 20.000.000 | Ăn giữa ca 730.000 | 1 |
| NV00008 | Phí Thị Loan | Kế toán | Kế toán viên | 1/7/2019 | — | Không xác định thời hạn | 13.000.000 | 13.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00009 | Đặng Minh Tuấn | Kinh doanh | Nhân viên kinh doanh | 3/9/2019 | — | Không xác định thời hạn | 14.000.000 | 14.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
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
| NV00029 | Đàm Văn Hưng | Kỹ thuật | Kỹ thuật viên | 5/9/2023 | — | Không xác định thời hạn | 12.000.000 | 12.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00030 | Âu Minh Trí | Kinh doanh | Nhân viên kinh doanh | 2/10/2023 | 15/10/2026 | Không xác định thời hạn | 10.500.000 | 10.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00031 | Khúc Thị Vân | Kế toán | Thủ quỹ | 1/2/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00032 | Quan Thị My | Pháp chế | Chuyên viên pháp chế | 4/3/2024 | — | Không xác định thời hạn | 14.000.000 | 14.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00033 | Hoàng Thị Yến | Kinh doanh | Nhân viên kinh doanh | 1/4/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00034 | Kiều Văn Tâm | Kho vận | Nhân viên kho | 1/7/2024 | — | Không xác định thời hạn | 5.400.000; 5.800.000 từ 1/3/2027 | 5.400.000; 5.800.000 từ 1/3/2027 | Ăn giữa ca 730.000 | 0 |
| NV00035 | Phạm Văn Cường | Kinh doanh | Nhân viên kinh doanh | 15/7/2024 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00036 | Lương Văn Bình | Kho vận | Nhân viên kho | 1/10/2024 | — | Không xác định thời hạn | 6.000.000 | 5.310.000 | Ăn giữa ca 730.000 | 0 |
| NV00037 | Mạc Văn Toàn | Kỹ thuật | Kỹ sư | 2/12/2024 | — | Xác định thời hạn 2/12/2024–30/11/2026 | 16.000.000 | 16.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00038 | Đỗ Thị Hằng | Kinh doanh | Nhân viên kinh doanh | 2/12/2024 | — | Không xác định thời hạn | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00039 | Mai Văn Đức | Kinh doanh | Nhân viên kinh doanh | 3/2/2025 | — | Không xác định thời hạn | 10.000.000 | 10.000.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00040 | Hà Thị Bích | Kỹ thuật | Kỹ thuật viên | 1/4/2025 | — | Không xác định thời hạn | 11.000.000 | 11.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00041 | La Văn Khánh | Kỹ thuật | Kỹ sư | 5/1/2026 | — | Xác định thời hạn 12 tháng từ 5/1/2026 | 15.000.000 | 15.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00042 | Phùng Văn Hiếu | Kinh doanh | Nhân viên kinh doanh | 3/9/2026 | — | Thử việc 3/9–31/10/2026, nhóm cao đẳng trở lên, tối đa 60 ngày; rồi xác định thời hạn 12 tháng từ 1/11/2026 | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |
| NV00043 | Đinh Văn Quý | Kho vận | Nhân viên kho | 3/9/2026 | — | Thử việc 3/9–30/9/2026, nhóm nhân viên nghiệp vụ, tối đa 30 ngày; rồi xác định thời hạn 12 tháng từ 1/10/2026 | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00044 | Mã Văn Kiên | Kho vận | Nhân viên kho | 3/9/2026 | — | Thử việc 3/9–30/9/2026, nhóm nhân viên nghiệp vụ, tối đa 30 ngày; rồi xác định thời hạn 12 tháng từ 1/10/2026 | 7.000.000 | 7.000.000 | Ăn giữa ca 730.000 | 0 |
| NV00045 | Phan Thị Ngọc | Kinh doanh | Nhân viên kinh doanh | 1/10/2026 | — | Thử việc 1/10–29/11/2026, nhóm cao đẳng trở lên, tối đa 60 ngày; chưa có hợp đồng tiếp theo | Chưa có bản ghi lương | — | — | 0 |
| NV00046 | Dương Quốc Việt | Kinh doanh | Nhân viên kinh doanh | 1/10/2026 | — | Thử việc 1/10–29/11/2026, nhóm cao đẳng trở lên, tối đa 60 ngày; chưa có hợp đồng tiếp theo | 9.500.000 | 9.500.000 | Ăn giữa ca 730.000; Điện thoại 300.000 | 0 |

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

**Số dư phép năm của Mai ngày 9/11/2026.** Phép năm cơ bản 12 ngày; ngày cuối mỗi tháng được cộng 1 ngày (BR-049).

| Date | Entry | Days | Balance |
|---|---|---|---|
| 1/1/2026 | Chuyển phép tồn từ 2025 | +3,0 | 3,0 |
| 31/1 và 28/2/2026 | Cộng phép 2 tháng | +2,0 | 5,0 |
| 12/3/2026 | Sử dụng 12/3 tới 13/3, trừ vào phép tồn (BR-052) | −2,0 | 3,0 |
| 31/3/2026 | Cộng phép | +1,0 | 4,0 |
| 1/4/2026 | Hủy phép tồn hết hạn | −1,0 | 3,0 |
| 30/4 tới 31/7/2026 | Cộng phép 4 tháng | +4,0 | 7,0 |
| 14/8/2026 | Sử dụng 14/8 | −1,0 | 6,0 |
| 31/8 tới 31/10/2026 | Cộng phép 3 tháng | +3,0 | 9,0 |

Số dư ngày 9/11 là 9,0 ngày và không còn phép tồn. Đơn 20/11 đã duyệt, 1,0 ngày, chưa trừ vào số dư. Khi Mai gửi đơn
1,5 ngày ở tình huống 1, form hiện số phép còn lại sau đơn là 9,0 − 1,0 − 1,5 = 6,5 ngày (BR-053).

**Bảng công của Mai:**

| Month | Standard days | Days worked | Paid leave | Paid days | Status on 9/11 |
|---|---|---|---|---|---|
| 8/2026 | 21 | 20 | 1, Phép năm 14/8 | 21 | Đã chốt |
| 9/2026 | 20 | 20 | 0 | 20 | Đã chốt |
| 10/2026 | 22 | 22 | 0 | 22 | Chưa chốt; Mai không có ngày chưa xử lý |

**Đơn nghỉ** của phòng Kinh doanh và Kỹ thuật dùng trong các tình huống:

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
| Lý Văn Phúc, Phạm Văn Cường | Chiều 24/12 | Phép năm | Gửi 6/11, chờ duyệt; chiều 24/12 phòng còn 10/15 | 9 |
| La Văn Khánh | 7/12 tới 9/12 và 10/12 tới 11/12 | Kết hôn 3 ngày, Phép năm 2 ngày; Bản thân kết hôn | Gửi trong một lần ngày 9/11 | 8 |

**Phép tồn năm 2027 của phòng Kinh doanh** (tình huống 19). Ngày 1/1/2027, 7 người có phép tồn, tổng 18 ngày, hạn
31/3. Không ai dùng phép tồn trong tháng 1 và 2, nên ngày 1/3 vẫn là 7 người và 18 ngày. Phép tồn của Mai: số dư 9,0
ngày 9/11, trừ 1,5 ngày đơn 13/11 tới 16/11 và 1,0 ngày đơn 20/11, cộng phép 30/11 và 31/12, còn 8,5 ngày cuối năm;
ngày 1/1/2027 chuyển 5,0 ngày, hủy 3,5 ngày (BR-051).

| Employee | Carryover 1/1 and 1/3/2027 | Used 3/3 to 5/3 | Left 9/3 |
|---|---|---|---|
| Trần Thị Mai | 5,0 | 0 | 5,0 |
| Bùi Thị Hoa | 3,0 | 3,0, từ 3/3 tới 5/3 | 0 |
| Ngô Thị Thảo | 3,0 | 0 | 3,0 |
| Trịnh Văn Khoa | 2,0 | 1,0, ngày 5/3 | 1,0 |
| Lý Văn Phúc | 2,0 | 2,0, từ 4/3 tới 5/3 | 0 |
| Hoàng Thị Yến | 2,0 | 2,0, từ 4/3 tới 5/3 | 0 |
| Đỗ Thị Hằng | 1,0 | 0 | 1,0 |
| **Total** | **18,0, 7 người** | **8,0** | **10,0, 4 người** |

Mức phủ thấp nhất của phòng trong 3/3 tới 5/3 là 11/15 ngày 5/3, trên ngưỡng 70%.

## Attendance

- **Tháng 10/2026:** đã nhập đủ chấm công, chưa chốt. Việc còn chặn (BR-089):
  - Giải trình của Lý Văn Phúc cho 28/10, gửi 30/10, chờ Lê Văn Hùng.
  - Giải trình của Hồ Văn Sơn cho 29/10, gửi 30/10, chờ Hồ Thị Thu.
  - Tạ Văn Hải, 26/10: Vắng chưa xử lý.
  - Lâm Thị Nga, 27/10: Thiếu chấm công.
  - Mạc Văn Toàn, 30/10: Thiếu chấm công.
  - Ngày 4/11, một ngày làm việc trước hạn 5/11, HR đã được báo về hai giải trình còn chờ (BR-218).
- **Tháng 11/2026:** HR nhập file từ 1/11 tới 6/11 lúc 8:30 ngày 9/11. File có 436 dòng: 43 người × 5 ngày làm việc × 2
  lần chấm, thiếu 4 lần ở các ngày dưới, thêm 2 lần của Châu Văn Lực ngày chủ nhật 1/11, 6 dòng trùng và 2 dòng có mã
  chấm công không khớp. Ba người được báo ngày chưa xử lý (BR-216):
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
- **Đi muộn của cả công ty:** tháng 6, 7, 8/2026 lần lượt 30, 31, 32 lần với 41 người; tháng 9 là 38 lần với 43 người.
  Bình quân mỗi người tăng từ 0,76 lên 0,88 lần, tức tăng 17%, dưới `signal_change_ratio`.

## Payroll

**Phiếu lương của Mai**, tháng 8 và tháng 9/2026 đã chốt (tình huống 14). Mai không có người phụ thuộc. Tháng 9, Mai
có bản ghi lương mới từ 1/9 với lý do "Điều chỉnh lương sau đánh giá, bỏ phụ cấp đi lại". Mai đạt giải thi đua bán hàng
tháng 8 nhưng khoản thưởng bị sót ở bảng lương tháng 8 đã chốt, nên HR thêm khoản truy lĩnh vào bảng lương tháng 9
(BR-118).

| Line | 8/2026 | 9/2026 | Change |
|---|---|---|---|
| Công chuẩn | 21 | 20 | −1 |
| Công hưởng lương | 21 | 20 | −1 |
| Lương theo công | 12.000.000 | 12.500.000 | +500.000 |
| Ăn giữa ca | 730.000 | 730.000 | 0 |
| Điện thoại | 300.000 | 300.000 | 0 |
| Đi lại | 500.000 | không có | không còn |
| Tổng thu nhập | 13.530.000 | 13.530.000 | 0 |
| Truy lĩnh thưởng thi đua tháng 8, chịu thuế | không có | 1.500.000 | mới |
| BHXH 8% | 960.000 | 1.000.000 | +40.000 |
| BHYT 1,5% | 180.000 | 187.500 | +7.500 |
| BHTN 1% | 120.000 | 125.000 | +5.000 |
| Thu nhập chịu thuế | 12.800.000 | 14.300.000 | +1.500.000 |
| Thu nhập tính thuế | 0, vì −3.960.000 âm | 0, vì −2.512.500 âm | — |
| Thuế TNCN | 0 | 0 | 0 |
| Thực lĩnh | 12.270.000 | 13.717.500 | +1.447.500 |
| Công ty đóng BHXH 17,5% | 2.100.000 | 2.187.500 | +87.500 |
| Công ty đóng BHYT 3% | 360.000 | 375.000 | +15.000 |
| Công ty đóng BHTN 1% | 120.000 | 125.000 | +5.000 |
| Kinh phí công đoàn 2% | 240.000 | 250.000 | +10.000 |

**Bảng lương theo phòng ban.** Chi phí lương tính theo BR-131: tổng thu nhập, cộng khoản điều chỉnh, cộng phần công ty
đóng.

| Department | 8/2026 | 9/2026 | 10/2026, side point 12/11, trước khi tính lại |
|---|---|---|---|
| Công ty Mẫu, giám đốc | 61.305.000 | 61.305.000 | 61.305.000 |
| Kinh doanh | 246.190.000 | 242.487.500 | 231.137.500, phiếu của Phan Thị Ngọc lỗi |
| Kho vận | 96.707.564 | 117.603.100 | 120.167.305 |
| Kỹ thuật | 171.860.000 | 171.860.000 | 171.860.000 |
| Kế toán | 76.315.000 | 76.315.000 | 76.315.000 |
| Hành chính – Nhân sự | 58.295.000 | 58.295.000 | 58.295.000 |
| Pháp chế | 40.980.000 | 40.980.000 | 40.980.000 |
| **Total** | **751.652.564** | **768.845.600** | **760.059.805** |
| Số phiếu | 41 | 43 | 44 |

- **Người vào mới tháng 9:** Phùng Văn Hiếu, Đinh Văn Quý và Mã Văn Kiên chỉ có hợp đồng thử việc trong tháng 9, nên
  không đóng bảo hiểm (BR-100) và bị khấu trừ thuế 10% (BR-113). Từ tháng 10, Quý và Kiên có hợp đồng xác định thời
  hạn nên đóng bảo hiểm; Hiếu vẫn thử việc tới 31/10.
- **Kho vận, tháng 9 so với tháng 8:** tăng 20.895.536 đồng, tức 21,6%. Phân rã: người vào mới, Đinh Văn Quý và Mã Văn
  Kiên, +16.772.500, gồm cả 1.312.500 tiền làm thêm của hai người; người nghỉ việc 0; làm thêm của người cũ +4.123.036;
  thay đổi lương, phụ cấp, khoản điều chỉnh và phần công ty đóng đều bằng 0. Tháng 9/2025 phòng Kho vận có 8 người và
  chi phí 92.400.000. Cả công ty chỉ tăng 2,3%, dưới `payroll_change_ratio`, nên chỉ phòng Kho vận có tín hiệu (tình
  huống 17).
- **Phòng Pháp chế khi Quân xem chi phí lương (tình huống 18):** Pháp chế có 2 người nên được gộp vào phòng ban gốc
  (BR-129). Quân thấy dòng "Công ty Mẫu và Pháp chế, 3 người" với 102.285.000 đồng của tháng 9.
- **Bảng lương tháng 10, side point 12/11 (tình huống 13):** bảng công tháng 10 đã chốt và bảng lương ở trạng thái Nháp.
  Bảng có 44 phiếu, gồm phiếu lỗi của Phan Thị Ngọc.
  - Lỗi: Phan Thị Ngọc chưa có bản ghi lương (BR-117); phiếu của Ngọc chưa có số.
  - Cảnh báo: Đinh Văn Quý thiếu số tài khoản ngân hàng (BR-126).
  - HR ghi bản ghi lương 9.500.000 từ 1/10 cho Ngọc, kèm Ăn giữa ca 730.000 và Điện thoại 300.000; bảng lương sang Cần
    tính lại (BR-119).
  - Tính lại: phiếu của Ngọc có tổng thu nhập 10.530.000, thuế 10% của 9.800.000 là 980.000 (BR-113), thực lĩnh
    9.550.000, và hết lỗi. Kinh doanh thành 241.667.500; tổng chi phí tháng 10 thành 770.589.805.
- **Lương tối thiểu vùng mới (tình huống 15):** HR thêm vùng I 5.600.000 từ 01/01/2027. Danh sách dưới mức sàn có hai
  người:
  - Kiều Văn Tâm: lương cơ bản và lương đóng bảo hiểm 5.400.000, thấp hơn 200.000. Tâm đã có bản ghi lương 5.800.000 từ
    01/03/2027, nên khoảng bị ảnh hưởng là 01/01/2027 tới 28/02/2027.
  - Lương Văn Bình: lương đóng bảo hiểm 5.310.000, thấp hơn 290.000, từ 01/01/2027.

**Làm thêm của phòng Kho vận.** Mọi giờ làm thêm từ tháng 8 tới tháng 10 là ban ngày vào ngày làm việc, hệ số
`ot_rate_working_day` 150%. Tiền làm thêm = số giờ × lương cơ bản ÷ công chuẩn ÷ 8 × 150% (BR-107, BR-108). Ví dụ Châu
Văn Lực tháng 9: 30 × 8.000.000 ÷ 20 ÷ 8 × 150% = 2.250.000.

| Code | Name | 8/2026 | 9/2026 | 10/2026 |
|---|---|---|---|---|
| NV00010 | Thái Văn Lộc | 10 giờ, 803.571 | 16 giờ, 1.350.000 | 16 giờ, 1.227.273 |
| NV00016 | Châu Văn Lực | 20 giờ, 1.428.571 | 30 giờ, 2.250.000 | 30 giờ, 2.045.455 |
| NV00020 | Hồ Văn Sơn | 18 giờ, 1.205.357 | 28 giờ, 1.968.750 | 28 giờ, 1.789.773 |
| NV00022 | Tạ Văn Hải | 10 giờ, 625.000 | 18 giờ, 1.181.250 | 18 giờ, 1.073.864 |
| NV00027 | Lâm Thị Nga | 8 giờ, 500.000 | 16 giờ, 1.050.000 | 16 giờ, 954.545 |
| NV00034 | Kiều Văn Tâm | 6 giờ, 289.286 | 14 giờ, 708.750 | 14 giờ, 644.318 |
| NV00036 | Lương Văn Bình | 6 giờ, 321.429 | 14 giờ, 787.500 | 14 giờ, 715.909 |
| NV00043 | Đinh Văn Quý | — | 10 giờ, 656.250 | 12 giờ, 715.909 |
| NV00044 | Mã Văn Kiên | — | 10 giờ, 656.250 | 12 giờ, 715.909 |
| **Total** | | **78 giờ, 5.173.214** | **156 giờ, 10.608.750** | **160 giờ, 9.882.955** |

## History

Số tổng hợp theo tháng, đã chốt công và lương. Không có số của từng người.

Số người cuối tháng của mỗi phòng ban giữ như cột Headcount 1/8/2026 ở mục Company, trừ Kỹ thuật có 7 người tới
12/2025; La Văn Khánh vào làm ngày 5/1/2026. Không ai nghỉ việc từ 9/2025 tới 7/2026. Lương của mọi phòng tăng khoảng
1,5% từ 1/2026. Kinh doanh tháng 12/2025 có thưởng thi đua cuối năm.

| Month | Headcount at month end | Leavers | Late arrivals, company | Late arrivals, Kho vận |
|---|---|---|---|---|
| 9/2025 | 40 | 0 | 27 | 8 |
| 10/2025 | 40 | 0 | 29 | 9 |
| 11/2025 | 40 | 0 | 30 | 10 |
| 12/2025 | 40 | 0 | 33 | 12 |
| 1/2026 | 41 | 0 | 28 | 9 |
| 2/2026 | 41 | 0 | 25 | 7 |
| 3/2026 | 41 | 0 | 27 | 8 |
| 4/2026 | 41 | 0 | 29 | 9 |
| 5/2026 | 41 | 0 | 31 | 10 |
| 6/2026 | 41 | 0 | 30 | 9 |
| 7/2026 | 41 | 0 | 31 | 10 |

**Chi phí lương theo phòng ban:**

| Month | Công ty Mẫu | Kinh doanh | Kho vận | Kỹ thuật | Kế toán | Hành chính – Nhân sự | Pháp chế | Total |
|---|---|---|---|---|---|---|---|---|
| 9/2025 | 60.385.000 | 235.943.000 | 92.400.000 | 150.316.000 | 75.170.000 | 57.421.000 | 40.365.000 | 712.000.000 |
| 10/2025 | 60.385.000 | 239.743.000 | 93.100.000 | 150.316.000 | 75.170.000 | 57.421.000 | 40.365.000 | 716.500.000 |
| 11/2025 | 60.385.000 | 241.543.000 | 95.800.000 | 150.316.000 | 75.170.000 | 57.421.000 | 40.365.000 | 721.000.000 |
| 12/2025 | 60.385.000 | 254.143.000 | 97.200.000 | 150.316.000 | 75.170.000 | 57.421.000 | 40.365.000 | 735.000.000 |
| 1/2026 | 61.305.000 | 239.545.000 | 94.000.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 742.300.000 |
| 2/2026 | 61.305.000 | 240.545.000 | 90.500.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 739.800.000 |
| 3/2026 | 61.305.000 | 240.045.000 | 95.300.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 744.100.000 |
| 4/2026 | 61.305.000 | 240.945.000 | 95.900.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 745.600.000 |
| 5/2026 | 61.305.000 | 242.045.000 | 96.100.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 746.900.000 |
| 6/2026 | 61.305.000 | 243.145.000 | 96.300.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 748.200.000 |
| 7/2026 | 61.305.000 | 244.245.000 | 96.500.000 | 171.860.000 | 76.315.000 | 58.295.000 | 40.980.000 | 749.500.000 |

## Signals on 9/11/2026

Tính lúc 0:00 ngày 9/11 theo mục Default signal types của [domain](../analysis/domain.md#default-signal-types), với
phạm vi ở mục Assumptions.

| Signal | Scope | Severity | Personas who see it | Numbers |
|---|---|---|---|---|
| Nghỉ việc tăng | Kinh doanh | Cao | Hùng, Quân, Hà | 3 người nghỉ việc từ 10/8 tới 9/11: Cao Văn Dũng 31/8, Tôn Nữ Hạnh 30/9, Âu Minh Trí 15/10. Đầu và cuối kỳ đều 15 người, tỷ lệ 20%; cả công ty có 3 người nghỉ trên bình quân 42 người, tỷ lệ 7,1% |
| Đơn chờ quá hạn | Cả công ty | Thường | Hùng, Hà | 2 đơn của phòng Kinh doanh chờ quá 2 ngày làm việc: Vũ Đức Long từ 2/11, Trịnh Văn Khoa từ 3/11 |
| Chi phí lương đổi lớn | Kho vận | Cao | Quân, Hà | Tháng 9 tăng 21,6% so với tháng 8 |
| Vắng không lý do hoặc đi muộn tăng | Kho vận | Thường | Quân, Hà | Đi muộn tháng 9 bình quân 1,8 lần mỗi người, so với 1,25 của tháng 6 tới 8 |
| Làm thêm gần giới hạn | Cả công ty | Thường | Quân, Hà | 2 người ở Kho vận từ 80% giới hạn tháng 11: Châu Văn Lực 36 giờ, Hồ Văn Sơn 33 giờ |
| Hợp đồng sắp hết hạn | Cả công ty | Cao | Hà | 3 hợp đồng chưa có hợp đồng tiếp theo: Phan Thị Ngọc và Dương Quốc Việt, thử việc tới 29/11/2026; Mạc Văn Toàn, xác định thời hạn tới 30/11/2026 |
| Ngày chưa xử lý | Cả công ty | Cao | Hà | Tháng 10: 3 ngày của 3 người, Kho vận 2 và Kỹ thuật 1 |
| Hồ sơ thiếu dữ liệu tính lương | Cả công ty | Cao | Hà | Phan Thị Ngọc thiếu bản ghi lương; Đinh Văn Quý thiếu số tài khoản |

- Lê Văn Hùng theo dõi tín hiệu Nghỉ việc tăng từ 26/10. Ngày đó khoảng tính là 27/7 tới 26/10, cũng có 3 người nghỉ
  việc; Kinh doanh 15 người đầu và cuối kỳ, tỷ lệ 20%; cả công ty 41 người ngày 27/7 và 43 người ngày 26/10, tỷ lệ
  7,1%. Ngày 9/11 là đủ `signal_follow_up_days` ngày, nên Hùng nhận nhắc kèm số liệu hiện tại (tình huống 16).
- Ngoài các tín hiệu trên, không loại nào đạt điều kiện, kể cả ở cấp công ty: chi phí lương cả công ty tăng 2,3% và đi
  muộn cả công ty tăng 17%. Tín hiệu Buổi dưới ngưỡng của sáng 12/11 chỉ xuất hiện ở lần tính đêm 9/11, sau khi Ngô Thị
  Thảo gửi đơn.
- Insight cho Quân (M6) gom ba tín hiệu liên quan tới Kho vận: chi phí lương, đi muộn và làm thêm. Insight chỉ nêu
  chúng xảy ra cùng kỳ (BR-184).

**Phép tồn, side point 2/3 và 9/3/2027 (tình huống 19).** Số liệu từng người ở bảng Phép tồn năm 2027 của mục Leave.

- Ngày 1/3, cả 7 người còn phép tồn nhận gợi ý dùng phép tồn (BR-170). Tín hiệu Phép tồn sắp hết hạn xuất hiện với 18
  ngày của 7 người; Hùng theo dõi tín hiệu này.
- Ngày 2/3, Hùng mở thẻ nhắc: 0 người nhận, 7 người bị bỏ vì vừa nhận gợi ý (EC-141).
- Ngày 9/3, đã qua `reminder_quiet_days`: 4 người còn tổng 10 ngày phép tồn là Mai, Thảo, Khoa và Hằng; thẻ nhắc gửi
  được cho cả 4.

## Policies and questions

| Policy | Version | Effective | Sections |
|---|---|---|---|
| Nội quy lao động | 2 | 1/1/2026 | 1. Thời giờ làm việc: 8:00 tới 17:00, nghỉ trưa 12:00 tới 13:00, thứ Hai tới thứ Sáu. 2. Chấm công và giải trình: quên chấm thì gửi giải trình trước hạn chốt công ngày 5 tháng sau. 3. Làm thêm giờ: đăng ký trước khi làm, tối đa 40 giờ mỗi tháng |
| Quy chế nghỉ phép | 3, thay bản 2 có hiệu lực 1/1/2025 | 1/7/2026 | 1. Phép năm: 12 ngày, cứ 5 năm thêm 1 ngày. 2. Nghỉ việc riêng có lương và không lương theo Điều 115. 3. Thủ tục: gửi đơn trên hệ thống; quản lý trực tiếp duyệt. 4. Phép tồn: chuyển tối đa 5 ngày sang năm sau, dùng tới hết 31/3 |
| Quy chế lương và phúc lợi | 1 | 1/1/2026 | 1. Kỳ lương theo tháng, trả ngày 10 tháng sau. 2. Phụ cấp: ăn giữa ca 730.000; điện thoại 300.000 cho kinh doanh; trách nhiệm cho trưởng phòng. 3. Thưởng thi đua: theo từng đợt do giám đốc duyệt, trả cùng lương của tháng có kết quả |

**Câu hỏi thường gặp:**

| Question | Linked section | Status |
|---|---|---|
| Quên chấm công thì làm gì? | Nội quy lao động, mục 2 | Đã đăng |
| Phép tồn dùng tới khi nào? | Quy chế nghỉ phép, mục 4 | Đã đăng, cờ cần rà lại vì quy chế có bản 3 (BR-194) |
| Khi nào nhận phiếu lương? | Quy chế lương và phúc lợi, mục 1 | Đã đăng |

**Câu hỏi gửi HR:**

| From | Sent | Question | Status on 9/11 |
|---|---|---|---|
| Trần Thị Mai | 12/10 | "Vì sao phiếu lương tháng 9 không còn phụ cấp đi lại?" | Đã trả lời bởi Phạm Thu Hà ngày 13/10: phụ cấp đi lại bỏ từ bản ghi lương 1/9 |
| Lâm Thị Nga | 4/11 | "Công ty có mua bảo hiểm sức khỏe cho người thân không?" | Chờ trả lời 3 ngày làm việc; mọi HR được nhắc (tình huống 20) |
| Hoàng Thị Yến | 6/11 | "Em đổi số tài khoản ngân hàng thì báo ai?" | Chờ trả lời |

**Kịch bản chat** (M6):

- **Tình huống 2:** Mai gõ "nghỉ chiều thứ Sáu tuần này và cả thứ Hai tuần sau, đám cưới em trai". Chat hiện phương án
  của AI Leave Coordinator: 1,5 ngày Phép năm, lý do Anh chị em ruột kết hôn; hoặc 1,5 ngày Việc riêng không lương. Chọn
  một phương án thì mở SCR-020.
- **Tình huống 5 qua chat:** Mai gõ "dời đơn ngày 20/11 sang thứ Hai". Coordinator đề xuất 23/11; SCR-020 mở ở chế độ
  Đổi đơn, kèm cảnh báo giai đoạn Cao điểm cuối năm.
- **Tình huống 21:**
  - Mai hỏi "Phép năm chưa nghỉ hết có được chuyển sang năm sau không?". Assistant trả lời: được chuyển tối đa 5 ngày,
    dùng tới hết 31/3. Nguồn là Quy chế nghỉ phép mục 4 và cấu hình `carryover_max_days`, `carryover_expiry`.
  - Mai hỏi "Công ty có hỗ trợ học phí tiếng Anh không?". Assistant nói không có nguồn, rồi đề nghị gửi câu hỏi cho HR.
    SCR-051 mở với câu hỏi và tóm tắt hội thoại soạn sẵn.

## Situations

Tình huống trong [prototype](prototype.md#mock-data) và nơi có dữ liệu của nó trong file này.

| # | Section |
|---|---|
| 1, 2, 5 | Leave: số dư và hai đơn của Trần Thị Mai; Chat scripts |
| 3, 4, 6, 7, 8, 9 | Leave: bảng Đơn nghỉ |
| 10, 11, 12 | Attendance |
| 13, 14, 15, 17, 18 | Payroll |
| 16 | Signals on 9/11/2026 |
| 19 | Leave: Phép tồn năm 2027; Signals on 9/11/2026 |
| 20, 21 | Policies and questions; Chat scripts |
