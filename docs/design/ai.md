# AI component

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [ARCHITECTURE](../../ARCHITECTURE.md) · [requirements](../analysis/requirements.md) ·
  [AI components guide](../playbook/ai-components.md)

> Điền khi sản phẩm có tính năng AI; nếu không thì bỏ file. Component AI được thiết kế như mọi component khác: có
> contract, có cách xử lý khi lỗi, có chi phí và có cách đo. Nguyên tắc và eval-lite nằm ở AI components guide. Chỉ ghi
> phần thực sự có; không thêm tool hay agent cho đủ mẫu. Dòng in nghiêng là ví dụ, xóa khi điền.

## Task

- **Stories:** [US-xxx]
- **Input:** [component nhận gì]
- **Output:** [component trả gì, ai dùng]
- **Done by code:** [phần tính toán, kiểm quyền, so ngưỡng, ghi dữ liệu. LLM chọn, code tính.]
- **Needs a human:** [bước người dùng xác nhận trước khi kết quả được dùng]
- **Fallback:** [khi AI lỗi, chậm hoặc không chắc thì sản phẩm làm gì]

## Contract

- **Schema:** [file schema của đầu ra; đầu ra được validate trước khi dùng]

| Field | Type | Rule |
|---|---|---|
| *`attendees`* | *Số nguyên ≥ 1, hoặc `null`* | *Câu không nhắc số người thì trả `null`, không đoán* |
| *`needs`* | *Danh sách thiết bị trong danh mục có sẵn* | *Thiết bị ngoài danh mục bị bỏ, không thêm mới* |

## Pipeline

| Step | Input → Output | Model or code | Prompt or config | On failure |
|---|---|---|---|---|
| *parse* | *Câu mô tả → yêu cầu đặt phòng dạng JSON* | *[model ID]* | *`prompts/parse.md` v1* | *Sai schema: gọi lại 1 lần, rồi chuyển sang form thường* |
| *find_slots* | *Yêu cầu → tối đa 3 phòng và khung giờ trống* | *Code, không dùng LLM* | *—* | *Không có chỗ trống: báo và gợi ý ngày khác* |

- **LLM calls in sequence:** [số lần gọi nối tiếp trong một request] · **Latency budget:** [p95]

## Guardrails

Chỉ ghi rủi ro có thật, lấy từ failure mode trong brief. Status `Planned` nghĩa là chưa có bằng chứng biện pháp đó đã
hoạt động.

| Risk | Control | Where | Status |
|---|---|---|---|
| *Đầu ra sai định dạng* | *Validate theo JSON schema* | *[vị trí]* | *Planned* |
| *Câu mô tả chứa lệnh điều khiển model* | *Câu của người dùng nằm trong khối dữ liệu; model không có tool nào* | *[vị trí]* | *Planned* |

## Versioning and cost

- **Prompts:** [nơi lưu, cách đánh version]
- **Model:** [model ID; ghim version nếu provider hỗ trợ, nếu không thì cách phát hiện provider đổi model]
- **Budget:** [chi phí mỗi request và mỗi tháng; giới hạn chi tiêu đặt ở đâu]

## Eval-lite

- **Smoke set:** [đường dẫn trong `eval/`, số ca, nhóm ca; ca tổng hợp đánh dấu `synthetic`]
- **Command:** [lệnh chạy]
- **Runs:** khi PR đổi prompt, model, provider hoặc pipeline; ghi kết quả trước và sau vào PR.

| Metric | Scorer | Target |
|---|---|---|
| *Parse đúng số người và thiết bị* | *Code: so khớp với đáp án* | *≥ 90% trên smoke set* |
| *Không đoán khi thiếu thông tin* | *Code: field thiếu phải là `null`* | *100%* |

## Results

| Date | Commit / prompt / model | Result | Notes |
|---|---|---|---|
| *[YYYY-MM-DD]* | *`a1b2c3d` / v1 / [model ID]* | *Parse 92%, null 100%* | *Lỗi chủ yếu ở câu nhắc "cả team" mà không có số người* |
