# Brief: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án đọc lại; không có AI review
- **Related:** [questions](questions.md) · [research](research.md) · [requirements](requirements.md) ·
  [decisions](decisions/README.md)

## Origin

Chủ dự án muốn xây một hệ thống quản lý nhân sự chạy trên web cho doanh nghiệp nhỏ và vừa tại Việt Nam. Hệ thống gồm
sáu nhóm chức năng: quản trị hệ thống, quản lý nhân viên, cơ cấu tổ chức, chấm công và nghỉ phép, lương và phúc lợi,
báo cáo và phân tích. Tính năng AI là hướng mở rộng, làm sau khi phần nghiệp vụ đã xong.


## Problem

Ở công ty mục tiêu, nhân viên xin nghỉ bằng cách nhắn Zalo hoặc nói trực tiếp với quản lý, và quản lý duyệt bằng lời.
Không có nơi nào ghi lại số ngày phép đã dùng, nên cả nhân viên lẫn HR đều không biết chính xác mỗi người còn bao nhiêu
ngày. Cuối tháng, HR phải lục lại tin nhắn để tính công, rồi tính lương trên các bảng tính rời rạc. Hậu quả là công và
lương dễ bị tính sai, và nhân viên với HR hay tranh cãi về số ngày phép còn lại.

Mô tả trên là nhận định của chủ dự án, chưa được công ty xác nhận. Các câu cần hỏi công ty để kiểm chứng nằm ở
[questions](questions.md).

## Users

Cột Current workaround là nhận định của chủ dự án, chưa được công ty xác nhận.

| User | Need | Current workaround |
|---|---|---|
| Nhân viên | Gửi đơn nghỉ và biết mình còn bao nhiêu ngày phép | Nhắn Zalo cho quản lý; hỏi HR khi cần biết số ngày phép còn lại |
| Quản lý trực tiếp | Duyệt đơn nghỉ của nhóm và biết ai vắng ngày nào | Nhận đơn qua Zalo hoặc nói miệng, duyệt bằng lời |
| HR | Quản lý hồ sơ, theo dõi nghỉ phép, tổng hợp công và lương ở một nơi | Dùng nhiều bảng tính; lục lại tin nhắn Zalo khi tính công |
| Ban giám đốc | Xem tình hình nhân sự và chi phí lương | Nhờ HR hoặc kế toán lập báo cáo |

## Alternatives

| Option | Why not enough |
|---|---|
| Bảng tính và Zalo, cách công ty đang dùng | Không có luồng duyệt và không tự tính số ngày phép còn lại; HR tổng hợp công và lương bằng tay |
| Phần mềm HRM trong nước như MISA AMIS HRM, Base HRM, 1Office | Đủ chức năng, nhưng dùng sản phẩm có sẵn thì không đạt mục tiêu luyện phân tích và thiết kế |
| Odoo HR, mã nguồn mở | Tùy biến được, nhưng thứ học được là cách cấu hình Odoo, không phải cách thiết kế hệ thống |
| Tự làm | Đạt được cả hai mục tiêu nêu ở mục Origin |

## Solution

Một web app cho bốn nhóm người dùng của một công ty. Nhân viên tự gửi đơn nghỉ và xem số ngày phép còn lại. Quản lý
duyệt đơn ngay trên hệ thống. HR quản lý hồ sơ, cơ cấu tổ chức, bảng công và bảng lương ở một nơi. Ban giám đốc xem báo
cáo nhân sự và chi phí lương. Hệ thống tự tính số ngày phép, công và lương theo luật lao động và quy chế của công ty.

- **AI role:** Bản đầu chưa có tính năng AI. Khi thêm AI sau này, AI không tính tiền và không quyết định quyền; những
  việc đó do code đảm nhận.

## Scope

- **In:**
  - Phân tích chi tiết cả năm milestone dưới đây trước khi code. Phân rã chức năng nằm ở
    [research](research.md#decomposition).
  - Thiết kế kiến trúc và dữ liệu cho cả năm milestone; thiết kế API và giao diện chi tiết cho MVP.
  - MVP, bản phát hành đầu tiên: M1, M2 và các báo cáo của M5 không cần dữ liệu chấm công hay lương. Danh sách story ở cột
    MVP của [stories](stories.md#summary). Chủ dự án chọn ngày 2026-10-30, để công ty dùng thử sớm phần giải chỗ đau xin
    nghỉ trước hai milestone có nhiều rủi ro về luật là M3 và M4.
  - M1: đăng nhập, vai trò, hồ sơ nhân viên, cơ cấu tổ chức.
  - M2: nghỉ phép.
  - M3: chấm công.
  - M4: lương và phúc lợi.
  - M5: báo cáo và phân tích.
- **Out:**
  - Tính năng AI: milestone M6, làm sau năm milestone trên.
  - Phục vụ nhiều công ty trên cùng một hệ thống (SaaS): mục tiêu là một công ty dùng.
  - Tuyển dụng, onboarding và đánh giá hiệu suất: nằm ngoài sáu nhóm chức năng đã chọn.
  - Dữ liệu nhân viên thật: chỉ dùng dữ liệu giả cho tới khi có thỏa thuận với công ty.
- **Constraints:**
  - Hệ thống chạy trên web.
  - Một người làm cùng coding agent, khoảng 6 giờ mỗi ngày.
  - Phân tích và thiết kế phải xong trước 2026-11-12. Code làm sau mốc này; chưa đặt ngày phát hành.
  - Hệ thống phải tuân theo luật Việt Nam về lao động, bảo hiểm xã hội, thuế thu nhập cá nhân và bảo vệ dữ liệu cá
    nhân. Danh sách văn bản nằm ở [research](research.md#legal-sources).

## Success metrics

Baseline và Target ở hai dòng cuối là ước lượng của chủ dự án; chỉnh lại sau khi hỏi công ty.

| Metric | Baseline | Target | Measured by |
|---|---|---|---|
| Số hạng mục phân tích và thiết kế đã chốt | 0 trên 13 | 13 trên 13 trước 2026-11-12 | Số Issue đã đóng trong milestone `Baseline` trên GitHub |
| Tỷ lệ đơn nghỉ ở công ty mục tiêu được gửi và duyệt trên hệ thống | 0%; mọi đơn đi qua Zalo hoặc nói miệng | 100% sau 4 tuần dùng thử | Đối chiếu số đơn trên hệ thống với danh sách nghỉ của HR |
| Thời gian HR trả lời câu "nhân viên X còn bao nhiêu ngày phép" | Chưa đo | Dưới 1 phút | Hỏi HR sau 4 tuần dùng thử |

## Risks

| Risk | Type | Mitigation or spike |
|---|---|---|
| Công ty mục tiêu không đau nhất ở nghỉ phép, hoặc không muốn dùng hệ thống | Product | Hỏi HR công ty về chỗ đau và cách làm hiện tại trước khi chốt requirements |
| Không kịp phân tích và thiết kế cả năm milestone trước 2026-11-12 | Time | Xem tiến độ mỗi Chủ nhật; nếu trễ thì lùi mốc, không làm lướt các bước kiểm tra |
| Luật về lương (bảo hiểm xã hội, thuế thu nhập cá nhân, làm thêm giờ) phức tạp và đang thay đổi, dễ dẫn tới tính sai tiền | Technical | Đối chiếu văn bản gốc khi phân tích; mỗi luật ghi rõ nguồn và có test; tỷ lệ và mức giảm trừ đặt trong cấu hình, không viết cứng trong code |
| Dữ liệu thay đổi theo thời gian, như chuyển phòng ban hay tăng lương từ một ngày hiệu lực, làm mô hình dữ liệu phức tạp | Technical | Thiết kế kỹ ở Phase 3 và ghi quyết định vào ADR; cân nhắc spike sau khi chọn DB |
| Dữ liệu cá nhân của nhân viên (lương, CCCD, tài khoản ngân hàng) chịu Luật Bảo vệ dữ liệu cá nhân | Legal | Chỉ dùng dữ liệu giả cho tới khi có thỏa thuận với công ty; xác định dữ liệu nhạy cảm khi phân tích domain |

**Spike:** Phase 1 chưa cần spike, vì hai lý do. Rủi ro kỹ thuật lớn nhất là luật về lương, và việc đối chiếu văn bản
luật ở Phase 2 xử lý rủi ro này. Ngoài ra, chưa chọn stack nên chưa có nền để viết code thử.

## Decision

Go · 2026-10-29. Dù chỗ đau thật của công ty là gì, thứ tự làm các milestone vẫn giữ nguyên, vì mỗi module cần dữ liệu
của module trước nó. Do đó Phase 2 bắt đầu được ngay trong lúc chờ hỏi công ty.
