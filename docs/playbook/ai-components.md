# AI components

Trang này dùng khi sản phẩm có tính năng AI. Playbook coi phần AI là một component như mọi component khác: phân tích
từ user story, thiết kế có contract và cách xử lý lỗi, và đo bằng một bộ eval gọn. Lựa chọn của dự án ghi ở
[design/ai.md](../design/ai.md). AI agent hỗ trợ làm dự án là chuyện khác, nằm ở [hats.md](hats.md).

## In analysis

- Tính năng AI bắt đầu từ user story như mọi tính năng: người dùng cần gì, không phải "dùng AI để làm gì".
- Acceptance criteria ghi cả trường hợp AI sai: người dùng thấy gì và sửa thế nào.
- Liệt kê 3–5 failure mode nặng nhất vào mục Risks của brief, ví dụ trả sai, bịa thông tin, chậm, tốn tiền, bị nội
  dung đầu vào dẫn dắt. Failure mode nào sản phẩm phải xử lý thì thành `EC-xxx`.
- Có cách giải không dùng AI, như rule, form hay tìm kiếm, thì ghi vào mục Alternatives của brief. Chưa rõ cách nào tốt
  hơn thì spike so sánh cả hai.

## In design

- **LLM chọn, code tính.** LLM trích xuất, phân loại, soạn thảo. Code tính tiền, kiểm quyền, so ngưỡng và ghi DB.
- **Contract có schema.** Đầu ra của model được validate trước khi dùng; sai schema thì có đường xử lý rõ ràng.
- **Luôn có fallback.** AI lỗi, chậm hoặc không chắc thì sản phẩm vẫn dùng được, thường bằng luồng không dùng AI.
- **Người xác nhận trước tác động.** Kết quả AI dẫn tới hành động khó đảo ngược thì người dùng xác nhận trước.
- **Đi qua một module.** Mọi lời gọi model đi qua một module, để log, đo chi phí, mock trong test và đổi provider ở một
  chỗ.
- **Có version.** Prompt có version trong repo; model ghi ID. Đổi prompt hay model mà hành vi thay đổi là loại Behavior
  trong [change-control.md](change-control.md).
- **Bề mặt tấn công có thật.** LLM đọc nội dung không tin cậy thì có nguy cơ prompt injection; có tool thì giới hạn
  quyền của tool. Chỉ thêm biện pháp cho bề mặt mà sản phẩm thật sự có.

## Eval-lite

Eval là chạy component AI trên một tập ca có đáp án hoặc tiêu chí chấm. Unit test mock LLM để kiểm logic; eval gọi
model thật để đo hành vi. Hai loại không thay thế nhau.

| Topic | Default |
|---|---|
| Smoke set | 10–30 ca trong `eval/`: ca thường, ca biên, mỗi failure mode ít nhất 2 ca |
| Scorer | Ưu tiên code: exact match, schema, regex. LLM judge chỉ dùng khi cần đọc hiểu, kèm rubric, và tự chấm lại một phần mẫu |
| When to run | PR đổi prompt, model, provider hoặc pipeline; khi provider báo đổi model |
| Reporting | PR ghi kết quả trước và sau, trên cùng dataset và cùng cách chấm |
| New cases | Lỗi thật trên production: ẩn danh rồi thêm vào smoke set |
| Data | Chỉ commit dữ liệu tổng hợp hoặc đã ẩn danh; ca do AI sinh đánh dấu `synthetic` |

- LLM không tất định. Khi kết quả sát ngưỡng, chạy lặp 2–3 lần và ghi độ lệch.
- Ca đã được xem để sửa prompt thì không còn là bằng chứng độc lập. Eval-lite chấp nhận điều đó; cần bằng chứng mạnh
  hơn thì xem mục dưới.

## When to go beyond eval-lite

Nâng lên eval đầy đủ khi một trong các điều sau đúng: kết quả AI ảnh hưởng tới tiền, quyền hoặc quyết định về người
khác; có nhiều bước AI nối tiếp hoặc agent có tool; sản phẩm có nhiều người dùng và lỗi AI khó thấy bằng mắt.

Eval đầy đủ gồm golden set 50–100 ca, chia dev set để tinh chỉnh và test set chỉ dùng để kết luận; test set được freeze
và chạy ở release gate. Ghi quyết định nâng cấp và cách làm vào một ADR.
