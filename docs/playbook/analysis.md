# Analysis

Analysis trả lời ba câu: ai dùng hệ thống và cần làm gì, luật nào phải luôn đúng, hệ thống cần tốt tới mức nào. Đây chưa
phải lúc trả lời câu "làm bằng gì". Kết quả ghi ở [requirements](../requirements.md), [stories](../stories.md),
[domain](../domain.md) và [UI flow](../ui-flow.md). Phase 2 làm phần này cho baseline; Feature loop ở Phase 4 làm lại
cho từng feature, ở quy mô nhỏ hơn.

## Workflow

| Step | Technique | Output | Recorded in |
|---|---|---|---|
| 1 | Actors and goals | Actor, mục tiêu, quyền, ma trận phân quyền | requirements: Actors |
| 2 | User stories | `US-xxx` kèm acceptance criteria | stories |
| 3 | Use cases | `UC-xxx` cho luồng nhiều nhánh | requirements: Use cases |
| 4 | Domain modeling | Glossary, entity, aggregate, vòng đời | domain |
| 5 | Business rules, edge cases | `BR-xxx`, `EC-xxx`, parameters | domain |
| 6 | Quality attributes | `QA-xxx` có số đo và cách kiểm chứng, đã xếp hạng | requirements: Quality attributes |
| 7 | UI flow | `SCR-xxx` và luồng giữa các màn hình | ui-flow |
| 8 | Review | Analysis checklist | Dòng Reviewed của từng tài liệu |

Thứ tự này là gợi ý. Thường phải đi vòng giữa bước 2 và bước 4–5 vài lần: viết story lộ ra thuật ngữ mới, mô hình
domain lộ ra story còn thiếu.

## Actors and goals

- Actor là ai hoặc cái gì tương tác với hệ thống để đạt một mục tiêu: người theo vai (không theo tên), hệ thống ngoài,
  và thời gian khi có việc tự chạy theo lịch.
- Mỗi actor ghi mục tiêu và quyền. Actor không có mục tiêu riêng có thể chỉ là một vai khác của actor đã có.
- Hệ thống ngoài là một phần của bài toán, ví dụ lịch cá nhân mà người dùng đang dùng, thì ghi đúng tên. Đây không
  phải chọn công nghệ: công nghệ dùng để xây hệ thống mới được chọn ở Phase 3.
- Thiếu actor thường lộ ra muộn dưới dạng câu hỏi về quyền, ví dụ "ai được hủy lịch của người khác?". Liệt kê sớm thì
  hỏi sớm.
- Có từ hai vai trò người: lập ma trận phân quyền, mỗi thao tác trong story một dòng, mỗi vai trò một cột. Ô nào chưa
  điền được là một câu hỏi `Q-xxx`.

## User stories

- **Form:** "Là [actor], tôi muốn [việc] để [mục tiêu]". Phần "để" là giá trị của story; không viết được phần đó thì
  có thể story không cần.
- **Size:** một story vừa một feature, độc lập với story khác ở mức có thể, và kiểm được. Story `Must` phải đạt INVEST
  trong Definition of Ready của [working-agreement.md](working-agreement.md) trước khi vào milestone.
- **Format:** mỗi story một mục trong `stories.md`: story, link tới UC, BR, EC, SCR, rồi acceptance criteria.
- **Priority:** `Must` khi thiếu story đó thì bản phát hành vô nghĩa; `Should`, `Could` cho phần còn lại. Phần không
  làm ghi vào Non-goals.

**Acceptance criteria**

- Ghi điều quan sát được từ bên ngoài: người dùng thấy gì, dữ liệu đổi ra sao.
- Luật và nhánh dùng dạng Given / When / Then. Mỗi tiêu chí kiểm được bằng một test hoặc một bước thử tay.
- Có ít nhất một nhánh thất bại chính.
- Dẫn `BR-xxx` thay vì viết lại luật.

| Unclear | Clearer |
|---|---|
| Không cho đặt trùng lịch. | Given phòng A có lịch 9:00–10:00, when đặt phòng A 9:30–10:30, then bị từ chối với lý do trùng lịch và không có lịch mới (BR-001). |
| Người tham dự được thông báo. | Khi lịch bị hủy, mỗi người tham dự nhận email trong 5 phút, có tên phòng và giờ. |
| Đặt phòng phải dễ. | Người dùng mới đặt được phòng đầu tiên trong 1 phút mà không cần hướng dẫn (QA-006). |

**Splitting a large story**

- Theo bước của quy trình: tạo trước, sửa và hủy sau.
- Theo luật: bản đầu chỉ có luật cơ bản, luật ngoại lệ ở story sau.
- Theo biến thể dữ liệu: lịch một lần trước, lịch lặp sau.
- Theo actor: thành viên trước, quản trị sau.
- Happy path trước, nhánh lỗi hiếm sau, miễn là nhánh lỗi nặng có mặt trong bản phát hành.

## Use cases

**When:** story có nhiều bước tương tác qua lại, nhiều nhánh, nhiều actor, hoặc có tác động khó đảo ngược như thanh
toán, xóa dữ liệu, gửi ra ngoài. Không viết use case cho CRUD đơn giản.

Story ghi giá trị và tiêu chí đạt. Use case ghi cuộc trao đổi giữa actor và hệ thống, gồm cả các nhánh. Một use case
thường phủ một hoặc vài story. Ở Phase 3, sequence diagram là bản hiện thực của use case.

**How**

1. Viết main flow 3–9 bước, xen kẽ actor và hệ thống. Mỗi bước một câu, chủ ngữ là actor hoặc "Hệ thống".
2. Với từng bước, hỏi "chỗ này có thể khác đi hoặc hỏng thế nào?". Vẫn đạt mục tiêu bằng đường khác thì là alternative
   flow; không đạt mục tiêu thì là exception. Đánh số theo bước: `3a`, `3b`.
3. Mỗi exception thành `EC-xxx` hoặc `BR-xxx` trong domain.
4. Postconditions ghi điều đúng sau khi kết thúc, kể cả khi thất bại: dữ liệu nào đã ghi, đã gửi gì ra ngoài.
5. Ghi ý định của actor ("chọn khung giờ"), không ghi giao diện ("bấm nút xanh") hay công nghệ ("gọi API").

```text
UC-002: Đặt lịch lặp hằng tuần
Main flow
  1. Thành viên chọn phòng, khung giờ và số tuần lặp.
  2. Hệ thống kiểm từng lần lặp với các lịch đã có.
  3. Hệ thống hiện danh sách lần lặp, đánh dấu lần bị trùng.
  4. Thành viên xác nhận.
  5. Hệ thống tạo các lịch không trùng và báo những lần bị bỏ qua.
Exceptions
  3a. Mọi lần lặp đều trùng: hệ thống báo và không tạo lịch nào (EC-004).
  4a. Trong lúc thành viên xác nhận, người khác đặt mất một khung giờ: lần đó bị bỏ qua và được báo lại (EC-005).
```

## Domain modeling

Playbook dùng DDD-lite: chỉ lấy phần của Domain-Driven Design giúp hiểu nghiệp vụ và giữ luật đúng, không cần đủ bộ
khái niệm.

### Glossary

- Chỉ ghi từ mà người dùng, tài liệu và code có thể hiểu khác nhau.
- Code dùng đúng tên ở cột Code name. Đổi tên trong glossary thì đổi trong code.
- Tìm thuật ngữ trong danh từ của user story và trong lời người dùng. Hai từ cùng nghĩa thì chọn một; một từ hai nghĩa
  thì tách thành hai thuật ngữ.

### Entities and value objects

- **Entity** có danh tính, sống qua thời gian và đổi trạng thái, ví dụ `Booking`, `Member`.
- **Value object** chỉ có giá trị, không có danh tính và không đổi sau khi tạo; hai value object bằng nhau khi giá trị
  bằng nhau, ví dụ `TimeSlot`, `Money`, `Email`. Đặt luật của giá trị vào đây: `TimeSlot` luôn có giờ kết thúc sau giờ
  bắt đầu.
- Quan hệ ghi bội số (một–nhiều) và chiều sở hữu. Domain model chưa phải schema: không ghi khóa ngoại, kiểu cột hay
  bảng trung gian.

### Aggregates and invariants

- **Invariant** là luật phải đúng sau mỗi thao tác, không chỉ đúng "vào cuối ngày".
- **Aggregate** là nhóm entity và value object phải được cập nhật cùng nhau để giữ invariant. Mỗi aggregate có một
  root; bên ngoài chỉ tham chiếu tới root bằng ID.
- Giữ aggregate nhỏ. Luật trải trên nhiều aggregate, như "không hai lịch chồng giờ trên cùng một phòng", không ép vào
  một aggregate lớn; ghi lại để Phase 3 chọn cơ chế như constraint DB, khóa hoặc hàng đợi.
- Bỏ mục này khi app chủ yếu là CRUD và không có luật nhất quán giữa nhiều entity.

### Lifecycles

- Entity có trạng thái thì có một state machine và một bảng chuyển trạng thái: From, To, trigger và actor, guard.
- Với mỗi cặp trạng thái, hỏi: có chuyển được không, ai được chuyển, khi nào. Chuyển trạng thái không có trong bảng là
  không được phép.
- Trạng thái cuối có quay lại được không, ví dụ hủy rồi khôi phục, thường là một câu hỏi `Q-xxx`.

### Business rules

- Mỗi luật một dòng dạng When / Then, có nguồn và Status.
- Luật đến từ lời người dùng, quy định có sẵn, guard của state machine, invariant và exception của use case.
- Con số trong luật đưa vào bảng Parameters, để đổi con số mà không phải sửa luật.
- Status `Confirmed` khi có nguồn xác nhận, `Assumed` khi dựa trên assumption `A-xxx`, `Disputed` khi các nguồn mâu
  thuẫn. Luật `Disputed` không được đưa vào code.

### Bounded contexts

- Chỉ cần khi cùng một từ mang hai nghĩa ở hai phần của hệ thống. Ví dụ "phòng" với bên đặt lịch là chỗ họp, với bên
  quản lý tài sản là tài sản có thiết bị. Khi đó tách glossary theo context và ghi cách hai context trao đổi dữ liệu.
- Dự án một người thường chỉ có một context. Ghi một câu như vậy ở đầu domain là đủ.

## Edge cases

Đi qua từng nguồn dưới đây cho mỗi story `Must`. Mỗi ca ghi cách xử lý mong muốn; chưa biết thì ghi `Undecided` và mở
`Q-xxx`.

| Source | Ask |
|---|---|
| Exception của use case | Bước này hỏng thì sao? |
| Biên của tham số | 0, 1, tối đa, đúng bằng ngưỡng, vượt ngưỡng một đơn vị |
| Thời gian | Qua nửa đêm, khác timezone, quá hạn, sự kiện tới muộn |
| Đồng thời | Hai người cùng làm một việc; một người bấm hai lần |
| Dữ liệu | Trống, trùng, rất dài, ký tự đặc biệt, dữ liệu cũ có trước luật mới |
| Quyền | Người không có quyền thử làm; quyền bị thu hồi giữa chừng |
| Phụ thuộc | Hệ thống ngoài chậm, lỗi hoặc trả kết quả lạ |

## Quality attributes

"Nhanh", "an toàn" hay "dễ mở rộng" không thiết kế được và không kiểm được. Viết mỗi yêu cầu chất lượng thành một
scenario có số đo:

> Khi [tác nhân] [làm gì] trong [điều kiện], hệ thống [phản ứng] trong [số đo].

Bản đầy đủ của scenario có sáu phần: source, stimulus, environment, artifact, response, response measure. Bảng trong
requirements gộp lại thành hai cột Scenario và Measure.

- **Ranking:** xếp mỗi scenario theo Importance (người dùng quan tâm bao nhiêu) và Difficulty (khó đạt bao nhiêu với
  một thiết kế đơn giản), mỗi trục `H`, `M`, `L`. Các dòng `H/H` và `H/M` là architecture driver ở Phase 3.
- **Guesses:** số đo đầu tiên thường là phỏng đoán. Ghi `(assumption)` và chỉnh lại sau lần đo ở milestone đầu.
- **Verification:** mỗi scenario ghi cách đo dự kiến, như load test, integration test hay hóa đơn hosting. Không nghĩ ra
  được cách đo thì scenario chưa đủ cụ thể.

| Attribute | Example scenario |
|---|---|
| Performance | Mở lịch tuần của một phòng khi có 50 người dùng cùng lúc: p95 < 500 ms |
| Availability | Hosting khởi động lại: hệ thống chạy lại trong 2 phút, không mất lịch đã xác nhận |
| Data integrity | Hai người đặt cùng khung giờ trong cùng một giây: đúng một lịch được tạo |
| Security | Thành viên gọi thao tác hủy lịch của người khác: bị từ chối và có log |
| Modifiability | Thêm loại tài nguyên thứ hai (xe công): chỉ sửa trong một module, không đổi cấu trúc dữ liệu của lịch đặt |
| Cost | 100 người dùng hoạt động mỗi tháng: chi phí hạ tầng < $10 |
| Usability | Người dùng mới đặt được phòng đầu tiên trong 1 phút, không cần hướng dẫn |
| Accessibility | Mọi thao tác đặt phòng làm được bằng bàn phím; đạt WCAG 2.2 mức AA |

## UI flow

- Analysis ghi người dùng thấy gì và đi qua màn hình nào. Đây chưa phải thiết kế giao diện chi tiết.
- Mỗi màn hình dẫn tới `US-xxx`. Màn hình không phục vụ story nào có thể là thừa; story không có màn hình hay interface
  nào là đang thiếu.
- Màn hình tải dữ liệu cần trạng thái loading, empty và error.

## Analysis checklist

Dùng khi review nguội và khi giao AI phản biện. Ở Feature loop, chỉ chạy các dòng liên quan tới phần delta.

- [ ] Mỗi actor có mục tiêu và quyền; mỗi thao tác trong story có actor được phép làm.
- [ ] Có từ hai vai trò người: ma trận phân quyền phủ mọi vai trò và mọi thao tác trong story.
- [ ] Mỗi story `Must` có acceptance criteria kiểm được, gồm ít nhất một nhánh thất bại, và đạt INVEST.
- [ ] Requirements và domain không chọn công nghệ: không có framework, DB hay dịch vụ dùng để xây hệ thống.
- [ ] Thuật ngữ dễ hiểu sai trong story và luật đều có trong glossary.
- [ ] Mỗi entity có trạng thái có state machine; mỗi chuyển trạng thái có trigger, actor và guard.
- [ ] Mỗi exception của use case đã thành `EC-xxx` hoặc `BR-xxx`.
- [ ] Luật trải trên nhiều aggregate đã được ghi lại để Phase 3 chọn cơ chế.
- [ ] Đã đi qua bảng nguồn edge case cho từng story `Must`.
- [ ] 3–5 quality attribute đứng đầu có số đo và cách kiểm chứng; số đo phỏng đoán có ghi `(assumption)`.
- [ ] Không còn luật `Disputed` trong phạm vi baseline; luật `Assumed` có `A-xxx` kèm hậu quả nếu sai.
- [ ] Mọi câu hỏi `blocks-design` đã có trả lời hoặc thành assumption.
- [ ] Mỗi màn hình dẫn tới story; mỗi story `Must` có màn hình hoặc interface.
