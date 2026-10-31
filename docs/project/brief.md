# Brief: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-31
- **Reviewed:** 2026-10-31: chủ dự án review diff ở #39; agent soạn
- **Related:** [questions](questions.md) · [research](research.md) · [requirements](../analysis/requirements.md) ·
  [decisions](../decisions/README.md)

## Origin

Chủ dự án muốn xây một hệ thống quản lý nhân sự chạy trên web cho doanh nghiệp nhỏ và vừa tại Việt Nam. Hệ thống gồm
sáu nhóm chức năng: quản trị hệ thống, quản lý nhân viên, cơ cấu tổ chức, chấm công và nghỉ phép, lương và phúc lợi,
báo cáo và phân tích. AI là trọng tâm của sản phẩm, gồm ba tính năng: điều phối nghỉ phép, phân tích báo cáo trên trang
tổng quan và trợ lý HR dạng chat. Phần AI gồm cả tính năng người dùng thao tác trực tiếp và tự động hóa trong quy trình.
Phần nghiệp vụ phải đủ và tính đúng trước, AI được xây trên nền đó.

## Problem

Ở công ty mục tiêu, nhân viên xin nghỉ bằng cách nhắn Zalo hoặc nói trực tiếp với quản lý, và quản lý duyệt bằng lời.
Không có nơi nào ghi lại số ngày phép đã dùng, nên cả nhân viên lẫn HR đều không biết chính xác mỗi người còn bao nhiêu
ngày. Cuối tháng, HR phải lục lại tin nhắn để tính công, rồi tính lương trên các bảng tính rời rạc. Hậu quả là công và
lương dễ bị tính sai, và nhân viên với HR hay tranh cãi về số ngày phép còn lại.

Ba việc sau tốn thời gian của con người, và form hay bảng báo cáo không giải hết:

- Nhân viên hỏi HR qua Zalo về quy chế, số ngày phép còn lại và các khoản trên phiếu lương. HR trả lời lặp lại những câu
  giống nhau.
- Nhân viên không biết lý do nghỉ của mình thuộc loại nghỉ nào, ví dụ phép năm, nghỉ việc riêng có hưởng lương hay nghỉ
  không lương. Chọn sai loại thì đơn bị trả lại, hoặc lương bị tính sai. Đơn còn bị treo khi quản lý bận hay đang nghỉ,
  và vào mùa cao điểm nhiều người xin nghỉ cùng lúc, quản lý phải tự xếp để nhóm đủ người.
- Quản lý và ban giám đốc ít khi đọc hết các bảng báo cáo, nên không thấy kịp điều đáng chú ý, như một phòng ban có
  nhiều người nghỉ việc hay phép tồn của nhiều người sắp hết hạn.

Mô tả trên là nhận định của chủ dự án, chưa được công ty xác nhận. Các câu cần hỏi công ty để kiểm chứng nằm ở
[questions](questions.md), gồm Q-001, Q-002 và Q-024 tới Q-026.

## Users

Cột Current workaround là nhận định của chủ dự án, chưa được công ty xác nhận.

| User | Need | Current workaround |
|---|---|---|
| Nhân viên | Gửi đơn nghỉ đúng loại, biết mình còn bao nhiêu ngày phép, hỏi quy chế mà không phải chờ HR | Nhắn Zalo cho quản lý; hỏi HR khi cần biết số ngày phép hay quy chế |
| Quản lý trực tiếp | Duyệt đơn nghỉ của nhóm, biết ai vắng ngày nào và điều gì trong nhóm đáng chú ý | Nhận đơn qua Zalo hoặc nói miệng, duyệt bằng lời |
| HR | Quản lý hồ sơ, nghỉ phép, công và lương ở một nơi; bớt trả lời câu hỏi lặp lại | Dùng nhiều bảng tính; lục lại tin nhắn Zalo khi tính công; trả lời từng tin nhắn |
| Ban giám đốc | Biết tình hình nhân sự, chi phí lương và điều đáng chú ý mà không phải đọc hết bảng số | Nhờ HR hoặc kế toán lập báo cáo |

## Alternatives

| Option | Why not enough |
|---|---|
| Bảng tính và Zalo, cách công ty đang dùng | Không có luồng duyệt và không tự tính số ngày phép còn lại; HR tổng hợp công và lương bằng tay |
| Phần mềm HRM trong nước như MISA AMIS HRM, Base HRM, 1Office | Đủ chức năng, nhưng dùng sản phẩm có sẵn thì không đạt mục tiêu luyện phân tích và thiết kế |
| Odoo HR, mã nguồn mở | Tùy biến được, nhưng thứ học được là cách cấu hình Odoo, không phải cách thiết kế hệ thống |
| Trang quy chế và câu hỏi thường gặp, có ô tìm kiếm | Trả lời được câu hỏi chung, nhưng không trả lời được câu hỏi về dữ liệu của chính người hỏi; người dùng phải tự tìm đúng mục |
| Form chọn lý do nghỉ theo danh mục, rule ánh xạ lý do sang loại nghỉ | Chính xác và rẻ, nhưng không hiểu lý do gõ tự do hay lý do ngoài danh mục |
| Cảnh báo theo ngưỡng trên trang tổng quan | Bắt được điều đã định trước, như phép tồn sắp hết hạn; không giải thích được con số và không xếp được điều nào đáng chú ý hơn |
| Tự làm | Có hệ thống đủ nghiệp vụ và AI cho công ty, đồng thời đạt mục tiêu học trong [project](project.md#goals) |

Ba cách không dùng AI ở trên vẫn có giá trị riêng. Danh mục lý do nghỉ và cảnh báo theo ngưỡng thuộc lớp rule, chạy
được khi tắt AI; AI làm phần mà các cách này không làm được.

## Solution

Một web app cho bốn nhóm người dùng của một công ty, xây theo ba lớp. Mỗi lớp chỉ dựa vào lớp dưới nó, nên tắt AI thì
mọi nghiệp vụ vẫn làm được bằng form và báo cáo.

| Layer | Role | Examples |
|---|---|---|
| Core nghiệp vụ | Lưu dữ liệu và tính toán theo luật lao động và quy chế công ty; là nơi duy nhất quyết định dữ liệu đúng | Hồ sơ, cơ cấu tổ chức, đơn nghỉ và số dư phép, bảng công, bảng lương, báo cáo |
| Tự động hóa bằng rule | Chạy việc lặp lại theo lịch hoặc theo sự kiện; luật nằm trong code và cấu hình | Cộng phép hằng tháng, chuyển phép tồn, chọn người duyệt, thông báo, cảnh báo hợp đồng sắp hết hạn |
| AI | Hiểu câu tự nhiên, tóm tắt và gợi ý; đọc dữ liệu qua cùng lớp kiểm quyền như người dùng | Ba tính năng ở bảng dưới |

| AI feature | Users | What it does |
|---|---|---|
| AI Leave Coordinator | Mọi vai trò | Tham gia cả quy trình nghỉ phép, từ form hay chat: hiểu yêu cầu, đề xuất phương án hợp lệ, điều phối tình huống phát sinh, hỗ trợ người duyệt bằng tóm tắt tác động |
| AI Report Analyst | Quản lý, HR | Gom tín hiệu do rule phát hiện thành vài điều đáng chú ý trên trang tổng quan, giải thích bằng câu ngắn, soạn tin nhắc nhóm, viết cập nhật và tóm tắt tuần; mọi con số do core tính |
| AI HR Assistant | Mọi vai trò | Trợ lý dạng chat: trả lời câu hỏi về quy chế kèm nguồn, tra dữ liệu người hỏi có quyền xem, soạn sẵn yêu cầu để người hỏi xác nhận |

- **AI role:** AI không tính tiền, không quyết định quyền và không tự thay đổi dữ liệu nghiệp vụ như trạng thái đơn, số
  dư hay hồ sơ. AI được tự gửi giải thích, nhắc và ghi chú có nhãn AI. Mọi thay đổi đi qua core, do người có quyền xác
  nhận hoặc do rule; duyệt đơn luôn do người làm. Khi chạy theo sự kiện, AI chỉ đọc dữ liệu của tình huống đang xử lý,
  và người nhận chỉ thấy dữ liệu trong quyền của mình. Chi tiết ở BR-155 tới BR-165 trong
  [domain](../analysis/domain.md).
- Workflow, quyền hành động và điểm người xác nhận (human-in-the-loop) của AI Leave Coordinator ở UC-013 tới UC-015,
  của AI Report Analyst ở UC-016 và UC-017 trong [requirements](../analysis/requirements.md). AI HR Assistant được ghi
  khi phân tích tiếp.
- AI Report Analyst chỉ nhận số liệu mức nhóm do core tính, không nhận dữ liệu của từng người, và không nêu nguyên nhân
  ngoài phần phân rã con số của core (BR-182 tới BR-185).

## Scope

- **In:**
  - Phân tích chi tiết sáu milestone dưới đây trước khi code. Phân rã chức năng của M1–M5 nằm ở
    [research](research.md#decomposition).
  - UI prototype dùng dữ liệu giả và có design system, gồm cả màn hình của ba tính năng AI. Phạm vi màn hình chốt khi
    lập kế hoạch prototype.
  - Thiết kế kiến trúc, dữ liệu, API và giao diện sau khi prototype được duyệt; stack được chọn ở bước này.
  - v1.0, bản phát hành đầu tiên cho công ty, gồm mọi story của M1–M6. M1–M5 là mốc nội bộ: mỗi mốc qua release gate
    trên staging nhưng không giao cho công ty.
  - M1: đăng nhập, vai trò, hồ sơ nhân viên, cơ cấu tổ chức.
  - M2: nghỉ phép, gồm phần rule mà AI Leave Coordinator dựa vào: danh mục lý do nghỉ, ngưỡng nhân sự, nhắc và ủy quyền
    duyệt, đề nghị đổi ngày.
  - M3: chấm công.
  - M4: lương và phúc lợi.
  - M5: báo cáo và phân tích, gồm phần rule mà AI Report Analyst dựa vào: danh mục tín hiệu, phân rã chỉ số, thông báo,
    theo dõi tín hiệu và tóm tắt tuần.
  - M6: ba tính năng AI ở mục Solution, làm sau khi M1–M5 qua release gate, theo thứ tự AI Leave Coordinator, AI Report
    Analyst, AI HR Assistant.
- **Out:**
  - Phục vụ nhiều công ty trên cùng một hệ thống (SaaS): mục tiêu là một công ty dùng.
  - Tuyển dụng, onboarding và đánh giá hiệu suất: nằm ngoài sáu nhóm chức năng đã chọn.
  - AI đánh giá, xếp loại hay dự đoán về từng nhân viên, ví dụ dự đoán ai sắp nghỉ việc hay chấm điểm chuyên cần.
    Insight của AI chỉ ở mức nhóm; cảnh báo về một người chỉ đến từ rule, ví dụ phép tồn sắp hết hạn.
  - Dữ liệu nhân viên thật: chỉ dùng dữ liệu giả cho tới khi có thỏa thuận với công ty.
- **Constraints:**
  - Hệ thống chạy trên web.
  - Một người làm cùng coding agent, khoảng 6 giờ mỗi ngày.
  - Chưa viết code cho tới khi prototype được duyệt và stack được chọn. Chưa đặt ngày cho các mốc và ngày phát hành.
  - Hệ thống phải tuân theo luật Việt Nam về lao động, bảo hiểm xã hội, thuế thu nhập cá nhân và bảo vệ dữ liệu cá
    nhân. Danh sách văn bản nằm ở [research](research.md#legal-sources).

## Success metrics

Baseline và Target của các dòng đo ở công ty là ước lượng của chủ dự án; chỉnh lại sau khi hỏi công ty.

| Metric | Baseline | Target | Measured by |
|---|---|---|---|
| Số luồng đi được trên prototype, gồm các luồng trong [ui-flow](../analysis/ui-flow.md#flows) và luồng của ba tính năng AI | 0 | Mọi luồng; chủ dự án duyệt prototype | Đi thử từng luồng trên prototype; ghi kết quả vào Issue của prototype |
| Tỷ lệ đơn nghỉ ở công ty mục tiêu được gửi và duyệt trên hệ thống | 0%; mọi đơn đi qua Zalo hoặc nói miệng | 100% sau 4 tuần dùng thử | Đối chiếu số đơn trên hệ thống với danh sách nghỉ của HR |
| Thời gian HR trả lời câu "nhân viên X còn bao nhiêu ngày phép" | Chưa đo | Dưới 1 phút | Hỏi HR sau 4 tuần dùng thử |
| Số câu hỏi về quy chế, số ngày phép và lương HR nhận qua tin nhắn mỗi tuần | Chưa đo | Giảm một nửa sau 4 tuần dùng thử | HR đếm trong tuần trước và tuần cuối của đợt dùng thử |
| Tỷ lệ đơn nghỉ bị từ chối vì chọn sai loại nghỉ | Chưa đo | Dưới 5% | Đếm lý do từ chối trong 4 tuần dùng thử |
| Tỷ lệ đơn nghỉ có quyết định trong một ngày làm việc kể từ khi gửi | Chưa đo | Từ 90% trở lên | Đo trên hệ thống trong 4 tuần dùng thử |
| Tỷ lệ insight trên trang tổng quan được người xem đánh giá là hữu ích | Chưa có | Từ 70% trở lên | Đánh giá của người xem trên từng insight trong 4 tuần dùng thử |

## Risks

| Risk | Type | Mitigation or spike |
|---|---|---|
| Công ty mục tiêu không đau nhất ở nghỉ phép, hoặc không muốn dùng hệ thống | Product | Hỏi HR công ty về chỗ đau và cách làm hiện tại trước khi chốt requirements |
| Ba việc AI giải không phải chỗ đau thật của công ty | Product | Hỏi công ty theo Q-024 tới Q-026 trước khi chốt story của M6 |
| v1.0 gồm sáu milestone nên lâu mới có người dùng thật | Time | Mỗi mốc M1–M5 qua release gate trên staging; xem tiến độ mỗi Chủ nhật; cắt story theo priority khi cần |
| Luật về lương (bảo hiểm xã hội, thuế thu nhập cá nhân, làm thêm giờ) phức tạp và đang thay đổi, dễ dẫn tới tính sai tiền | Technical | Đối chiếu văn bản gốc khi phân tích; mỗi luật ghi rõ nguồn và có test; tỷ lệ và mức giảm trừ đặt trong cấu hình, không viết cứng trong code |
| Dữ liệu thay đổi theo thời gian, như chuyển phòng ban hay tăng lương từ một ngày hiệu lực, làm mô hình dữ liệu phức tạp | Technical | Thiết kế kỹ ở Phase 3 và ghi quyết định vào ADR; cân nhắc spike sau khi chọn DB |
| Dữ liệu cá nhân của nhân viên (lương, CCCD, tài khoản ngân hàng) chịu Luật Bảo vệ dữ liệu cá nhân; dữ liệu gửi tới dịch vụ AI bên ngoài có thể bị chuyển ra nước ngoài | Legal | Chỉ dùng dữ liệu giả cho tới khi có thỏa thuận với công ty; xác định dữ liệu nhạy cảm khi phân tích domain; gửi cho AI ít dữ liệu nhất có thể, cách làm chốt khi phân tích AI |
| AI trả lời sai quy chế hay luật, người dùng tin và làm theo | AI | AI chỉ trả lời từ tài liệu quy chế đã nạp và dẫn nguồn; không có nguồn thì nói không biết và chỉ tới HR |
| AI để lộ dữ liệu ngoài quyền của người nhận, ví dụ lương hay lý do nghỉ của đồng nghiệp | AI | AI đọc dữ liệu qua cùng lớp kiểm quyền như người dùng; khi chạy theo sự kiện, AI chỉ đọc dữ liệu của tình huống; đầu ra được lọc theo quyền người nhận (BR-159, BR-160) |
| AI bịa hoặc đọc sai số liệu trong insight hay giải thích | AI | Core tính mọi con số; code kiểm con số trong đầu ra của AI khớp với dữ liệu trước khi hiển thị (BR-163) |
| Nội dung người dùng nhập, như lý do nghỉ, chứa câu lệnh điều khiển AI (prompt injection) | AI | AI không tự thay đổi dữ liệu nghiệp vụ; thao tác chỉ chạy khi người có quyền xác nhận (BR-155 tới BR-158) |
| AI dẫn dắt quyết định duyệt, hoặc đề xuất dựa trên đặc điểm của người gửi | AI | AI chỉ nêu tác động và phương án; không gợi ý duyệt hay từ chối, không dùng lịch sử hay đặc điểm cá nhân (BR-164) |
| Nhân viên suy ra đồng nghiệp nào nghỉ từ cảnh báo nhóm thiếu người | Legal | Cảnh báo không kèm tên hay số người, và không hiện ở phòng ban nhỏ (BR-146) |
| AI nêu nguyên nhân không có trong số liệu, như đổ cho lương hay cách quản lý, khiến người đọc kết luận sai về một nhóm | AI | AI chỉ nhận số liệu mức nhóm và phân rã của core; không nêu nguyên nhân ngoài phân rã (BR-182, BR-184); eval chấm theo rubric (QA-010) |
| Quá nhiều thẻ cảnh báo, hoặc thẻ sai trọng tâm, nên người xem bỏ qua cả trang tổng quan | Product | Tín hiệu có ngưỡng và mức tối thiểu (BR-173); tối đa `insight_max_count` thẻ; người xem đánh giá và tắt từng loại; đo tỷ lệ hữu ích (BR-178) |
| Chi phí gọi model AI vượt ngân sách hạ tầng | Cost | Ước lượng chi phí và đặt giới hạn chi tiêu khi phân tích AI |

**Spike:** Chưa cần spike trước prototype. Rủi ro lớn nhất của phần nghiệp vụ là luật về lương, đã xử lý bằng việc đối
chiếu văn bản luật ở Phase 2. Rủi ro của AI, như độ chính xác khi gợi ý loại nghỉ từ câu tiếng Việt, cần spike sau khi
phân tích AI và trước khi chọn stack.

## Decision

Go · 2026-10-29. Dù chỗ đau thật của công ty là gì, thứ tự làm các milestone vẫn giữ nguyên: mỗi module cần dữ liệu của
module trước nó, và AI cần dữ liệu của cả năm module. Do đó việc phân tích và làm prototype bắt đầu được ngay trong lúc
chờ hỏi công ty.
