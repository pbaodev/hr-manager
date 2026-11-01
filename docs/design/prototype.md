# Prototype: hr-manager

- **Status:** Draft
- **Updated:** 2026-11-01
- **Reviewed:** [YYYY-MM-DD: chủ dự án duyệt prototype ở #61]
- **Related:** [project](../project/project.md) · [brief](../project/brief.md#success-metrics) ·
  [ui-flow](../analysis/ui-flow.md) · [stories](../analysis/stories.md) · [ui](ui.md)

> Kế hoạch cho mốc Prototype trong [project](../project/project.md). Prototype là giao diện mẫu dùng dữ liệu giả, để chủ
> dự án đi thử các luồng nghiệp vụ và luồng AI trước khi chọn stack ở Phase 3. Prototype không có code trong repo. Việc
> cần làm nằm ở Feature #52 trên tracker.

## Where

| Part | Location | Created in |
|---|---|---|
| Canvas prototype | claude.ai, Artifact loại Design | #55, các Task màn hình bổ sung dần |
| Design system | claude.ai, Artifact loại Design System | #54 |
| Dữ liệu giả | `docs/design/prototype-data.md` | #53 |

- Link của canvas và design system để riêng tư. Link được ghi ở mục Design sources của [ui](ui.md) khi Artifact được
  tạo. Nguồn của canvas nằm trên claude.ai, có lịch sử phiên bản; repo không giữ bản sao.
- Canvas có trang Đọc trước, ghi người dùng mẫu, mốc thời gian và cách đi các luồng. Sau đó là sáu trang M1 tới M6.
- Mỗi màn hình là một artboard rộng 1440 px. File đặt tên theo mã màn hình, thêm vai trò hoặc trạng thái khi có nhiều
  bản, ví dụ `scr-021-hr.dc.html` hay `scr-037-can-tinh-lai.dc.html`. Tiêu đề artboard ghi mã, tên màn hình và vai
  trò, ví dụ "SCR-021 Đơn chờ duyệt · HR".
- Artboard nối nhau bằng link để đi theo luồng. Thanh trên cùng của mỗi artboard ghi người dùng mẫu đang xem.
- Chủ dự án review bằng comment trên canvas.

## Screens

Vẽ đầy đủ 35 màn hình nằm trong các luồng của [ui-flow](../analysis/ui-flow.md#flows). Phần AI (M6) của các màn này
vẽ ở trang M6, để trang M1 tới M5 cho thấy hệ thống chạy được khi không có AI.

| Module | Full screens | Role variants | Representative | Task |
|---|---|---|---|---|
| M1 | SCR-001 tới SCR-004, SCR-007 tới SCR-012, SCR-049, SCR-051 | SCR-003: Nhân viên, Quản lý, HR. SCR-007, SCR-008: Quản lý, HR. SCR-051: Nhân viên, HR | SCR-014, SCR-050 | #55 |
| M2 | SCR-019 tới SCR-022 | SCR-021, SCR-022: Quản lý, HR | SCR-023 | #56 |
| M3 | SCR-027 tới SCR-032 | SCR-031: Quản lý, HR | — | #57 |
| M4 | SCR-034, SCR-035, SCR-037 tới SCR-039 | — | — | #58 |
| M5 | SCR-040 tới SCR-045, SCR-048 | SCR-040: Quản lý, Giám đốc, HR. SCR-045: Quản lý, HR | — | #59 |
| M6 | SCR-052 và phần AI ở mục AI | Theo vai trò của màn gốc | — | #60 |

17 màn quản trị và danh mục còn lại không vẽ riêng; mỗi màn dùng bố cục của một màn đã vẽ.

| Pattern | Screens using it |
|---|---|
| SCR-023: bảng danh mục, thêm, sửa, ngừng dùng | SCR-005, SCR-013, SCR-015, SCR-016, SCR-017, SCR-024, SCR-025, SCR-033, SCR-046, SCR-047 |
| SCR-014: cây phòng ban, thao tác có ngày hiệu lực và bước xem trước | SCR-006, SCR-026 |
| SCR-027: nhập file ba bước | SCR-018 |
| SCR-035: hộp thoại ghi bản ghi theo ngày hiệu lực | SCR-036 |

SCR-050 là mẫu riêng: soạn văn bản theo mục và theo phiên bản.

Màn hình có nhiều trạng thái trong ui-flow, như bảng lương Nháp, Cần tính lại, Đã chốt, thì mỗi trạng thái cần thử là
một artboard. Trạng thái không có ở mốc thời gian chính được vẽ thành artboard riêng, ghi rõ thời điểm giả định.

## Personas

Bốn người dùng mẫu dùng chung một bộ dữ liệu. Giám đốc không phải vai trò riêng: đó là Quản lý của phòng ban gốc
(BR-006).

| Persona | Role | Position | Used to try |
|---|---|---|---|
| Trần Thị Mai | Nhân viên | Nhân viên kinh doanh, phòng Kinh doanh | Gửi và đổi đơn, bảng công, giải trình, phiếu lương, câu hỏi gửi HR, chat |
| Lê Văn Hùng | Quản lý | Trưởng phòng Kinh doanh, quản lý trực tiếp của Mai | Duyệt đơn, lịch nghỉ và bảng công của nhóm, thẻ cảnh báo của phòng |
| Phạm Thu Hà | HR | Chuyên viên phòng Hành chính – Nhân sự | Hồ sơ, chấm công, lương, cấu hình, hộp câu hỏi |
| Nguyễn Minh Quân | Quản lý | Giám đốc, trưởng phòng ban gốc | Báo cáo toàn công ty, chi phí lương tổng hợp, tóm tắt tuần |

## Mock data

Mọi dữ liệu là giả theo brief: không tên, số CCCD, tài khoản ngân hàng hay dữ liệu nào của người thật. Chi tiết nằm ở
`docs/design/prototype-data.md`, tạo ở #53; mọi con số trên canvas lấy từ file đó.

**Công ty Mẫu**, khoảng 43 người, vùng lương tối thiểu I:

| Department | Headcount | Why |
|---|---|---|
| Công ty Mẫu, phòng ban gốc | 1, giám đốc | Phạm vi của Giám đốc |
| Kinh doanh | 15 | Phạm vi của Lê Văn Hùng; tín hiệu nghỉ việc tăng như US-090 AC1 |
| Kho vận | 10 | Làm thêm giờ, ca, nhiều tín hiệu cùng kỳ như US-096 AC2 |
| Kỹ thuật | 8 | Phòng ban bình thường để so sánh |
| Kế toán | 4 | |
| Hành chính – Nhân sự | 3 | Phòng của HR |
| Pháp chế | 2 | Dưới `report_min_group_size`; số liệu gộp vào phòng ban gốc (BR-129) |

**Mốc thời gian:**

- Hôm nay là thứ Hai 9/11/2026, giống ví dụ ở US-082 AC1.
- Tháng 8 và tháng 9/2026 đã chốt công và chốt lương.
- Tháng 10/2026 đã nhập đủ chấm công nhưng chưa chốt vì còn việc chặn; hạn chốt công là ngày 5/11
  (`attendance_close_day` là 5) và đã qua.
- Tháng 11/2026 đang diễn ra; file chấm công từ 1/11 tới 6/11 đã nhập.
- Mốc phụ 2/3/2027 chỉ dùng cho các màn về phép tồn sắp hết hạn, vì `carryover_expiry` là 31/3.

**Situations** cần dựng sẵn trong dữ liệu. Số liệu khớp ví dụ trong AC khi mốc thời gian cho phép.

| # | Situation | Stories, rules | Screens |
|---|---|---|---|
| 1 | Mai xin nghỉ chiều thứ Sáu 13/11 và thứ Hai 16/11 để dự đám cưới em trai | US-082 AC1, US-110 AC1 | SCR-020, SCR-052 |
| 2 | Một đơn phép năm của phòng Kinh doanh không còn đủ phép lúc duyệt | US-025 AC3, US-085 AC1, EC-030 | SCR-021, SCR-019 |
| 3 | Một đơn làm phòng Kinh doanh dưới ngưỡng nhân sự sáng 12/11 | US-075, US-088 AC1, BR-146 | SCR-020, SCR-021 |
| 4 | Một đơn chờ 4 ngày làm việc; HR được báo và duyệt thay | US-026, US-077 AC2 | SCR-003, SCR-021 |
| 5 | Mai đổi một đơn đã duyệt | US-080 AC4, AC5, EC-127 | SCR-019, SCR-020 |
| 6 | Một nhân viên gửi 3 ngày Kết hôn và 2 ngày Phép năm trong một lần | US-115 AC1, US-084 AC1 | SCR-020 |
| 7 | Mai thiếu giờ ra ngày 3/11 và được báo sau khi HR nhập file | US-117 AC1, BR-216 | SCR-003, SCR-027, SCR-028, SCR-029 |
| 8 | Tháng 10 còn 2 giải trình chờ duyệt và 3 ngày chưa xử lý; HR nhắc lại | US-048 AC1, US-116, US-117 AC5, US-118 | SCR-031, SCR-032 |
| 9 | Một nhân viên Kho vận đăng ký làm thêm vượt giới hạn tháng | US-044 AC4, BR-084 | SCR-030 |
| 10 | Phiếu lương tháng 9 của Mai có khoản truy lĩnh; so với tháng 8 | US-061, US-106 | SCR-038, SCR-039 |
| 11 | Lương tối thiểu vùng I tăng từ 01/01/2027; 2 bản ghi lương thấp hơn mức mới | US-119 AC1, AC2 | SCR-034, SCR-035 |
| 12 | Phòng Kinh doanh có 3 trên 15 người nghỉ việc trong 3 tháng | US-090 AC1 | SCR-040, SCR-048 |
| 13 | Chi phí lương tháng 9 đổi lớn so với tháng 8, có phân rã | US-091 AC1, US-097 AC1 | SCR-048 |
| 14 | Phòng Pháp chế 2 người: Quản lý thấy số liệu gộp vào phòng ban gốc | BR-129, EC-107 | SCR-045 |
| 15 | Mốc 2/3/2027: phòng Kinh doanh còn phép tồn sắp hết hạn; Quản lý gửi thẻ nhắc | US-086, US-098, EC-141 | SCR-019, SCR-048 |
| 16 | Một câu hỏi gửi HR chờ 2 ngày làm việc | US-104, US-105 AC2 | SCR-003, SCR-051 |
| 17 | Hỏi quy chế qua chat: một câu có nguồn, một câu không có nguồn | US-107, EC-117 | SCR-052, SCR-049 |

## AI

Nội dung của AI là văn bản soạn sẵn, chưa gọi model. Mỗi chỗ có AI được vẽ ba trạng thái:

- **Bình thường:** đầu ra có nhãn AI; thao tác chỉ xảy ra khi người dùng bấm xác nhận trên màn hình nghiệp vụ (BR-157,
  BR-204).
- **AI không chắc:** AI hỏi lại hoặc nói không biết, ở những chỗ có trường hợp này (BR-166, BR-200).
- **AI không dùng được, hoặc đầu ra không đạt kiểm tra:** màn hình chạy như không có AI (BR-162).

| Screen | AI part | Stories |
|---|---|---|
| SCR-020 | Ô mô tả nhu cầu nghỉ, câu hỏi làm rõ, cảnh báo lý do, phương án nghỉ | US-082 tới US-084 |
| SCR-003, SCR-019 | Giải thích tình huống, thẻ đề xuất, gợi ý dùng phép tồn | US-085, US-086 |
| SCR-021 | Tóm tắt tác động, soạn lý do từ chối hoặc lời đề nghị | US-088, US-089 |
| SCR-022 | Tổng hợp đơn trong giai đoạn hạn chế | US-087 |
| SCR-040, SCR-048 | Insight, giải thích, thẻ nhắc nhóm, cập nhật theo dõi | US-096 tới US-099 |
| SCR-003 | Tóm tắt tuần | US-100 |
| SCR-039 | Hỏi về phiếu lương này | US-109 |
| SCR-051 | Gợi ý mục câu hỏi thường gặp | US-113 |
| SCR-052 | Hỏi quy chế, tra dữ liệu, chuyển sang SCR-020 hoặc SCR-019, chuyển câu hỏi cho HR | US-107 tới US-112 |

## Review criteria

Dùng ở #61. Prototype đạt khi:

- Mọi luồng trong mục Flows của [ui-flow](../analysis/ui-flow.md#flows) và mọi luồng AI ở #60 bấm qua được, đúng
  Success metrics của [brief](../project/brief.md#success-metrics).
- Mỗi màn hình có nội dung, input, thông báo lỗi và trạng thái như ui-flow ghi.
- Mỗi biến thể vai trò chỉ có nút và dữ liệu mà vai trò đó được dùng theo Permission matrix trong
  [requirements](../analysis/requirements.md#permission-matrix).
- Mọi comment trên canvas đã được xử lý hoặc ghi lý do giữ nguyên.
- Chỗ prototype cho thấy tài liệu phân tích sai hay thiếu đã được sửa trong tài liệu, theo
  [change-control](../playbook/change-control.md) khi tài liệu đã `Accepted`, hoặc đã ghi thành Issue.

## Out of scope

- Code, stack, thư viện component và framework frontend: chọn ở Phase 3.
- Bản riêng cho màn hình điện thoại: prototype vẽ ở độ rộng 1440 px; cách co giãn ghi ở [ui](ui.md) ở Phase 3.
- Email và tin ngoài hệ thống: hệ thống không gửi, theo mục Thông báo trong [glossary](../analysis/domain.md#glossary).
- Gọi model AI thật: thuộc spike #48, #49 và Phase 3.
