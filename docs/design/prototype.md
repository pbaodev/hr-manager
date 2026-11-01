# Prototype: hr-manager

- **Status:** Draft
- **Updated:** 2026-11-01
- **Reviewed:** 2026-11-01: AI review bằng subagent `agent-skills:code-reviewer` ở PR #63; chủ dự án chưa duyệt
- **Related:** [project](../project/project.md) · [brief](../project/brief.md#success-metrics) ·
  [ui-flow](../analysis/ui-flow.md) · [stories](../analysis/stories.md) · [ui](ui.md)

Kế hoạch cho mốc Prototype trong [project](../project/project.md). Prototype là giao diện mẫu dùng dữ liệu giả, để chủ
dự án đi thử các luồng nghiệp vụ và luồng AI trước khi chọn stack ở Phase 3. Prototype không có code trong repo. Việc
cần làm nằm ở Feature #52 trên tracker. Kết quả duyệt prototype ghi ở mục Approval, tách khỏi dòng Reviewed của file
này.

## Where

| Part | Location | Created in |
|---|---|---|
| Canvas prototype | claude.ai, Artifact loại Design | #55, các Task màn hình bổ sung dần |
| Design system | claude.ai, Artifact loại Design System | #54 |
| Dữ liệu giả | `docs/design/prototype-data.md` | #53 |

- Link của canvas và design system để riêng tư. Link được ghi ở mục Design sources của [ui](ui.md) khi Artifact được
  tạo. Nguồn của canvas nằm trên claude.ai, có lịch sử phiên bản; repo không giữ bản sao.
- Canvas có trang Đọc trước, ghi người dùng mẫu, mốc thời gian và cách đi các luồng. Sau đó là sáu trang M1 tới M6.
- Mỗi màn hình là một artboard rộng 1440 px; canvas lưu mỗi artboard thành một file `.dc.html`. File đặt tên theo mã
  màn hình, thêm vai trò hoặc trạng thái khi có nhiều bản, ví dụ `scr-021-hr.dc.html` hay
  `scr-037-can-tinh-lai.dc.html`. Tiêu đề artboard ghi mã, tên màn hình và vai trò, ví dụ "SCR-021 Đơn chờ duyệt · HR".
- Artboard nối nhau bằng link để đi theo luồng. Thanh trên cùng của mỗi artboard ghi người đang xem: một trong bốn
  người dùng mẫu, hoặc nhân viên khác khi tình huống cần. Menu theo vai trò như bảng Menu trong
  [ui-flow](../analysis/ui-flow.md#information-architecture).
- Chủ dự án review bằng comment trên canvas.

## Screens

Vẽ 38 màn hình: 36 màn nằm trong mục [Flows](../analysis/ui-flow.md#flows) của ui-flow, và 2 màn đại diện cho bố cục
chưa có trong các luồng. 14 màn còn lại dùng bố cục của một màn đã vẽ. Phần AI (M6) của các màn vẽ ở trang M6, để trang
M1 tới M5 cho thấy hệ thống chạy được khi không có AI.

| Module | Screens in Flows | Representative | Role variants | Task |
|---|---|---|---|---|
| M1 | SCR-001 tới SCR-004, SCR-007 tới SCR-012, SCR-014, SCR-049, SCR-051 | SCR-050 | SCR-003: Nhân viên, Quản lý, HR. SCR-007, SCR-008: Quản lý, HR. SCR-049, SCR-051: Nhân viên, HR | #55 |
| M2 | SCR-019 tới SCR-022 | SCR-023 | SCR-020: Nhân viên, HR ghi đơn thay. SCR-021: Quản lý, HR | #56 |
| M3 | SCR-027 tới SCR-032 | — | SCR-031: Quản lý, HR | #57 |
| M4 | SCR-034, SCR-035, SCR-037 tới SCR-039 | — | — | #58 |
| M5 | SCR-040 tới SCR-045, SCR-048 | — | SCR-040, SCR-048: Quản lý, Giám đốc, HR. SCR-042, SCR-043: Quản lý, HR. SCR-045: Giám đốc, HR | #59 |
| M6 | SCR-052 và phần AI ở mục AI | — | SCR-052: Nhân viên, Quản lý, HR. Phần AI của màn khác theo biến thể của màn gốc | #60 |

| Pattern | Screens using it | Not covered by the pattern |
|---|---|---|
| SCR-007: danh sách có tìm và lọc | SCR-005, SCR-013, SCR-017, SCR-046 | SCR-017 chỉ xem. SCR-046 có hai tab, chọn nhiều dòng và hộp xác nhận không hoàn tác |
| SCR-023: bảng danh mục, thêm, sửa, ngừng dùng | SCR-015, SCR-016, SCR-024, SCR-025, SCR-033, SCR-047 | SCR-016: hộp thoại mật khẩu một lần. SCR-024: chọn năm, bước xem trước đơn bị ảnh hưởng (BR-064, EC-032). SCR-025: cảnh báo cần xác nhận (BR-069) |
| SCR-014: cây phòng ban | SCR-006 | Chỉ xem, không có thao tác |
| SCR-010: hộp thoại có ngày hiệu lực và bước xem trước | SCR-026 | Chọn ca và chọn nhân viên theo danh sách hoặc phòng ban |
| SCR-027: nhập file ba bước | SCR-018 | — |
| SCR-035: hộp thoại ghi bản ghi theo ngày hiệu lực | SCR-036 | — |

SCR-050 không có màn nào dùng lại; màn này đại diện cho việc soạn văn bản theo mục và theo phiên bản.

Màn hình có nhiều trạng thái trong ui-flow, như bảng lương Nháp, Cần tính lại, Đã chốt, thì mỗi trạng thái cần thử là
một artboard. Mỗi artboard ghi mốc thời gian nó dùng: hôm nay hoặc một side point ở mục Timeline.

## Personas

Bốn người dùng mẫu dùng chung một bộ dữ liệu. Giám đốc không có vai trò riêng: giám đốc là trưởng phòng ban gốc nên dùng
vai trò Quản lý với phạm vi toàn công ty, theo mục Actors trong [requirements](../analysis/requirements.md).

| Persona | Role | Position | Used to try |
|---|---|---|---|
| Trần Thị Mai | Nhân viên | Nhân viên kinh doanh, phòng Kinh doanh | Gửi và đổi đơn, bảng công, giải trình, phiếu lương, câu hỏi gửi HR, chat |
| Lê Văn Hùng | Quản lý | Trưởng phòng Kinh doanh, quản lý trực tiếp của Mai | Duyệt đơn, lịch nghỉ và bảng công của nhóm, thẻ cảnh báo, theo dõi tín hiệu, tóm tắt tuần |
| Phạm Thu Hà | HR | Chuyên viên phòng Hành chính – Nhân sự | Hồ sơ, chấm công, lương, cấu hình, hộp câu hỏi |
| Nguyễn Minh Quân | Quản lý | Giám đốc, trưởng phòng ban gốc | Báo cáo toàn công ty, chi phí lương tổng hợp, số liệu gộp của phòng ban nhỏ |

## Mock data

Mọi dữ liệu là giả theo brief: không tên, số CCCD, tài khoản ngân hàng hay dữ liệu nào của người thật. Chi tiết nằm ở
`docs/design/prototype-data.md`, tạo ở #53; mọi con số trên canvas lấy từ file đó.

**Company:** Công ty Mẫu, khoảng 43 người, vùng lương tối thiểu I.

| Department | Headcount | Why |
|---|---|---|
| Công ty Mẫu, phòng ban gốc | 1, giám đốc | Phạm vi của Giám đốc |
| Kinh doanh | 15 | Phạm vi của Lê Văn Hùng; tín hiệu nghỉ việc tăng như US-090 AC1; ngưỡng nhân sự riêng 70% (US-075 AC4) |
| Kho vận | 10 | Hai tín hiệu cùng kỳ: làm thêm gần giới hạn, vắng không lý do hoặc đi muộn tăng. Không có nghỉ việc tăng, để tỷ lệ nghỉ việc cả công ty giữ khoảng 8% như US-090 AC1 |
| Kỹ thuật | 8 | Phòng ban bình thường để so sánh |
| Kế toán | 4 | |
| Hành chính – Nhân sự | 3 | Phòng của HR |
| Pháp chế | 2 | Dưới `report_min_group_size`; số liệu gộp vào phòng ban gốc (BR-129) |

**Timeline:**

- Hôm nay là thứ Hai 9/11/2026, giống ví dụ ở US-082 AC1.
- Từ tháng 9/2025 tới tháng 7/2026 chỉ có số tổng hợp theo tháng và phòng ban, đã chốt công và lương. Số này đủ cho
  bình quân 3 tháng của tín hiệu (BR-172) và so với cùng kỳ năm trước (BR-176).
- Từ tháng 8/2026 có dữ liệu chi tiết từng người. Tháng 8 và tháng 9 đã chốt công và chốt lương.
- Tháng 10/2026 đã nhập đủ chấm công nhưng chưa chốt vì còn việc chặn. HR đã đặt `attendance_close_day` là 5, nên hạn
  chốt công 5/11 đã qua.
- Tháng 11/2026 đang diễn ra; file chấm công từ 1/11 tới 6/11 đã nhập.
- Phòng Kinh doanh và Kho vận có giai đoạn hạn chế nghỉ "Cao điểm cuối năm" từ 23/11 tới 31/12. Hôm nay còn đúng
  `peak_planning_days` ngày tới giai đoạn này (BR-171).
- **Side point 12/11/2026,** chỉ cho bảng lương: bảng công tháng 10 đã chốt; bảng lương tháng 10 ở trạng thái Nháp, có
  phiếu lỗi và cảnh báo. Sau khi HR sửa một bản ghi lương, bảng lương sang Cần tính lại.
- **Side point 2/3/2027,** chỉ cho phép tồn: `carryover_expiry` là 31/3 nên gợi ý dùng phép tồn (BR-170) và tín hiệu
  Phép tồn sắp hết hạn bắt đầu từ 1/3. Ngày 2/3 các gợi ý vừa gửi còn trong `reminder_quiet_days`, nên thẻ nhắc thấy
  được người bị bỏ qua (EC-141).

**Situations** cần dựng sẵn trong dữ liệu. Số liệu khớp ví dụ trong AC khi mốc thời gian cho phép.

| # | Situation | Stories, rules | Screens |
|---|---|---|---|
| 1 | Mai xin nghỉ chiều thứ Sáu 13/11 và thứ Hai 16/11 để dự đám cưới em trai | US-082 AC1 | SCR-020 |
| 2 | Mai gõ đúng câu của tình huống 1 trong chat và được đưa tới SCR-020 | US-110 AC1, AC2 | SCR-052, SCR-020 |
| 3 | Một đơn phép năm của phòng Kinh doanh không còn đủ phép lúc duyệt | US-025 AC3, US-085 AC1, EC-030 | SCR-021, SCR-019 |
| 4 | Sáng 12/11 phòng Kinh doanh đã có 4 người nghỉ; người thứ 5 gửi đơn làm mức phủ xuống 10/15, dưới ngưỡng 70% | US-075 AC1, AC4, US-088 AC1, BR-146 | SCR-020, SCR-021 |
| 5 | Mai có đơn phép năm đã duyệt ngày thứ Sáu 20/11 và dời sang thứ Hai 23/11, thấy cảnh báo giai đoạn hạn chế | US-080 AC4, AC5, US-110 AC3, EC-127, BR-147 | SCR-019, SCR-020, SCR-052 |
| 6 | Hùng đề nghị một đơn chờ của phòng Kinh doanh đổi sang 19/11 tới 20/11; nhân viên không đồng ý | US-079 AC1, AC4 | SCR-021, SCR-019 |
| 7 | Một đơn chờ 4 ngày làm việc; HR được báo và duyệt thay | US-026, US-077 AC2 | SCR-003, SCR-021 |
| 8 | Một nhân viên Kỹ thuật gửi 3 ngày Kết hôn và 2 ngày Phép năm trong một lần | US-115 AC1 | SCR-020 |
| 9 | Hùng nhận tổng hợp đơn của phòng Kinh doanh trong giai đoạn Cao điểm cuối năm | US-087 AC1, BR-171 | SCR-022 |
| 10 | Mai thiếu giờ ra ngày 3/11 và được báo sau khi HR nhập file | US-117 AC1, BR-216 | SCR-003, SCR-027, SCR-028, SCR-029 |
| 11 | Tháng 10 còn 2 giải trình chờ duyệt và 3 ngày chưa xử lý; HR nhắc lại | US-048 AC1, US-116, US-117 AC5, US-118 | SCR-031, SCR-032 |
| 12 | Một nhân viên Kho vận đăng ký làm thêm vượt giới hạn tháng | US-044 AC4, BR-084 | SCR-030 |
| 13 | Side point 12/11: bảng lương tháng 10 Nháp có phiếu thiếu bản ghi lương và phiếu thiếu số tài khoản; HR sửa rồi tính lại | US-055 AC4, US-060 AC2, BR-117, BR-119 | SCR-037, SCR-038, SCR-008, SCR-035 |
| 14 | Phiếu lương tháng 9 của Mai có khoản truy lĩnh; so với tháng 8 | US-061, US-106 | SCR-038, SCR-039 |
| 15 | Lương tối thiểu vùng I tăng từ 01/01/2027; 2 bản ghi lương thấp hơn mức mới | US-119 AC1, AC2 | SCR-034, SCR-035 |
| 16 | Phòng Kinh doanh có 3 trên 15 người nghỉ việc trong 3 tháng; Hùng theo dõi tín hiệu từ 26/10 và hôm nay nhận cập nhật | US-090 AC1, US-094 AC2, US-099 AC1 | SCR-040, SCR-048, SCR-003 |
| 17 | Chi phí lương tháng 9 đổi lớn so với tháng 8, có phân rã và so với tháng 9/2025 | US-091 AC1, US-097 AC1 | SCR-048 |
| 18 | Quân xem chi phí lương: phòng Pháp chế 2 người được gộp vào phòng ban gốc | BR-129 | SCR-045 |
| 19 | Side point 2/3/2027: phòng Kinh doanh còn phép tồn sắp hết hạn; Hùng gửi thẻ nhắc | US-086, US-098, EC-141 | SCR-019, SCR-048 |
| 20 | Một câu hỏi gửi HR chờ 3 ngày làm việc | US-104, US-105 AC2, BR-196 | SCR-003, SCR-051 |
| 21 | Hỏi quy chế qua chat: một câu có nguồn; một câu không có nguồn, được chuyển cho HR kèm tóm tắt | US-107, US-112, EC-117 | SCR-052, SCR-049, SCR-051 |

## AI

Nội dung của AI là văn bản soạn sẵn, chưa gọi model. Mỗi chỗ có AI được vẽ ba trạng thái:

- **Bình thường:** đầu ra có nhãn AI; thao tác chỉ xảy ra khi người dùng bấm xác nhận trên màn hình nghiệp vụ (BR-157,
  BR-204).
- **AI không chắc:** AI hỏi lại hoặc nói không biết, ở những chỗ có trường hợp này (BR-166, BR-200).
- **AI không dùng được, hoặc đầu ra không đạt kiểm tra:** màn hình chạy như không có AI (BR-162), kèm thông báo hoặc
  nội dung mẫu ở mục States của màn đó trong ui-flow. Ví dụ: SCR-040 hiện thẻ cảnh báo của rule (BR-188); SCR-003 và
  SCR-048 dùng nội dung mẫu (BR-191).

SCR-052 vẽ thêm hai trạng thái: người hỏi không có quyền với dữ liệu (BR-198), và câu hỏi chạm dữ liệu Assistant không
đọc (BR-199).

| Screen | AI part | Stories |
|---|---|---|
| SCR-020 | Ô mô tả nhu cầu nghỉ, câu hỏi làm rõ, cảnh báo lý do, phương án nghỉ | US-082 tới US-084 |
| SCR-003, SCR-019 | Giải thích tình huống, thẻ đề xuất, gợi ý dùng phép tồn | US-085, US-086 |
| SCR-021 | Tóm tắt tác động, soạn lý do từ chối hoặc lời đề nghị | US-088, US-089 |
| SCR-022 | Tổng hợp đơn trong giai đoạn hạn chế | US-087 |
| SCR-040, SCR-048 | Insight, giải thích, thẻ nhắc nhóm, cập nhật theo dõi | US-096 tới US-099 |
| SCR-003 | Cập nhật theo dõi, tóm tắt tuần | US-099, US-100 |
| SCR-039 | Hỏi về phiếu lương này | US-109 |
| SCR-051 | Câu hỏi và tóm tắt hội thoại soạn sẵn khi mở từ chat; gợi ý mục câu hỏi thường gặp | US-112, US-113 |
| SCR-052 | Hỏi quy chế, tra dữ liệu, chuyển sang SCR-020 hoặc SCR-019, chuyển câu hỏi cho HR | US-107 tới US-112 |

## Review criteria

Dùng ở #61. Prototype đạt khi:

- Mọi luồng trong mục Flows của [ui-flow](../analysis/ui-flow.md#flows) và mọi luồng AI ở #60 bấm qua được, đúng
  Success metrics của [brief](../project/brief.md#success-metrics).
- Mỗi màn được vẽ có nội dung, input, thông báo lỗi và trạng thái như ui-flow ghi. Màn dùng mẫu chỉ được kiểm qua bảng
  Pattern: phần mẫu không phủ phải ghi ở cột Not covered by the pattern.
- Mỗi biến thể vai trò chỉ có nút và dữ liệu mà vai trò đó được dùng theo Permission matrix trong
  [requirements](../analysis/requirements.md#permission-matrix).
- Mọi comment trên canvas đã được xử lý hoặc ghi lý do giữ nguyên.
- Chỗ prototype cho thấy tài liệu phân tích sai hay thiếu đã được sửa trong tài liệu, theo
  [change-control](../playbook/change-control.md) khi tài liệu đã `Accepted`, hoặc đã ghi thành Issue.

## Approval

[YYYY-MM-DD: chủ dự án duyệt prototype ở #61; link phiên bản canvas đã duyệt]

## Out of scope

- Code, stack, thư viện component và framework frontend: chọn ở Phase 3.
- Bản riêng cho màn hình điện thoại: prototype vẽ ở độ rộng 1440 px; cách co giãn ghi ở [ui](ui.md) ở Phase 3.
- Email và tin ngoài hệ thống: hệ thống không gửi, theo mục Thông báo trong [glossary](../analysis/domain.md#glossary).
- Gọi model AI thật: thuộc spike #48, #49 và Phase 3.
