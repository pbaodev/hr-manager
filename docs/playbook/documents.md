# Documents

Danh mục tài liệu của dự án, quy ước chung của các mẫu và cách viết. Người và agent tra trang này để biết một thông
tin nằm ở đâu.

## Map

Mỗi thông tin có một nơi chính. Nơi khác cần thì dẫn link hoặc mã, không chép lại.

| Document | Answers | Hat | Phase |
|---|---|---|---|
| [project.md](../project.md) | Mục tiêu, quỹ thời gian, công cụ, làm khác default ở đâu | Ops | 0 |
| [brief.md](../brief.md) | Có nên làm không, làm theo hướng nào | Analyst | 1 |
| [questions.md](../questions.md) | Điều chưa biết, assumption và câu trả lời | Analyst | 1 trở đi |
| [decisions/](../decisions/README.md) | Vì sao chọn phương án này, đã cân nhắc phương án nào | Architect | 1 trở đi |
| [requirements.md](../requirements.md) | Ai dùng, được làm gì, tốt tới mức nào | Analyst | 2 |
| [stories.md](../stories.md) | Người dùng cần gì, thế nào là đạt | Analyst | 2 |
| [domain.md](../domain.md) | Thuật ngữ, entity, vòng đời, luật nghiệp vụ, edge case | Analyst | 2 |
| [ui-flow.md](../ui-flow.md) | Người dùng thấy và làm gì trên từng màn hình | Analyst | 2 |
| [ARCHITECTURE.md](../../ARCHITECTURE.md) | Hệ thống gồm gì, kiến trúc được chọn vì quality attribute nào | Architect | 3 |
| [design/components.md](../design/components.md) | Bên trong container gồm module nào, phụ thuộc thế nào | Architect | 3 |
| [design/data.md](../design/data.md) | Dữ liệu lưu thế nào, luật nào được giữ ở tầng dữ liệu | Architect | 3 |
| [design/api.md](../design/api.md) | Client gọi hệ thống thế nào, lỗi trả về ra sao | Architect | 3 |
| [design/flows.md](../design/flows.md) | Mỗi luồng chính chạy qua những thành phần nào | Architect | 3 |
| [design/ui.md](../design/ui.md) | Quy tắc giao diện chung: design system, trạng thái, định dạng, accessibility | Architect | 3 |
| [design/ai.md](../design/ai.md) | Component AI làm gì, khi lỗi thì sao, đo bằng gì | Architect | 3 |
| `contracts/openapi.yaml` | Contract chính xác của API | Architect | 3 |
| [conventions/](../conventions/README.md) | Quy tắc code mà máy không tự kiểm được | Architect | 3 trở đi |
| [SPEC.md](../SPEC.md) | Module nào làm gì, yêu cầu nằm ở đâu, kiểm bằng gì, đã tới trạng thái nào | Architect | 3 |
| [setup.md](../setup.md) | Chạy dự án trên máy sạch thế nào | Ops | 3 |
| [testing.md](../testing.md) | Ca thử tay, mức lỗi, kết quả test của từng bản phát hành | Developer | 3 trở đi |
| [CHANGELOG.md](../../CHANGELOG.md) | Mỗi bản phát hành đổi gì cho người dùng | Ops | 4 |
| [runbook.md](../runbook.md) | Deploy, rollback, khôi phục và xử lý sự cố thế nào | Ops | 5 |
| [user-guide.md](../user-guide.md) | Người dùng cuối làm từng việc thế nào | Analyst | 5 |
| [handover.md](../handover.md) | Đã bàn giao gì, còn lại gì; chỉ cho Client delivery | Ops | 5 |
| [Feature](../../.github/ISSUE_TEMPLATE/feature.md), [Task](../../.github/ISSUE_TEMPLATE/task.md), [Bug](../../.github/ISSUE_TEMPLATE/bug.md), [Spike](../../.github/ISSUE_TEMPLATE/spike.md), [CR](../../.github/ISSUE_TEMPLATE/change_request.md), [PR](../../.github/PULL_REQUEST_TEMPLATE.md) | Công việc, thay đổi và bằng chứng | Developer | 1 trở đi |

`docs/playbook/` là hướng dẫn của template. Mọi file khác trong `docs/`, cùng `ARCHITECTURE.md`, là tài liệu của dự
án. Bảng Project types trong [README](README.md) cho biết loại dự án nào cần tài liệu nào.

## Template conventions

- **Header:** Status, Updated, Reviewed, Related, nằm ngay dưới tiêu đề. Không có dòng Owner vì một người giữ mọi tài
  liệu; mũ phụ trách ghi ở bảng Map.
- **Status:** tài liệu dùng `Draft`, `Accepted`, `Superseded`; ADR dùng thêm `Proposed` và `Rejected`. Chỉ `Accepted`
  là đã chốt. Mục còn trống, dòng ví dụ, tài liệu `Draft` hoặc `Proposed` đều chưa phải quyết định.
- **Reviewed:** ngày review nguội, cộng AI hay người nào đã review. Tài liệu chỉ chuyển sang `Accepted` khi dòng này đã
  điền.
- **Guidance:** một blockquote ở đầu mẫu, nói khi nào điền và điền thế nào. Có thể xóa khi tài liệu đã `Accepted`.
- **Placeholder:** `[…]`. Không dùng `<…>`, vì Markdown coi đó là thẻ HTML và ẩn đi khi render.
- **Examples:** dòng in nghiêng trong bảng, xóa khi điền. Các mẫu dùng chung một ví dụ: hệ thống đặt phòng họp, có tính
  năng AI gợi ý phòng từ câu mô tả.
- **Not applicable:** bỏ mục hoặc bỏ cả file, không ghi "N/A". Mục cần mà chưa có câu trả lời thì mở câu hỏi `Q-xxx`.
- **Language:** tên file, heading, tên phase, nhãn trường, header bảng, giá trị Status và mã dùng tiếng Anh. Phần giải
  thích viết tiếng Việt.

## IDs

Mã không được dùng lại cho nghĩa khác. Bỏ một mục thì giữ dòng và ghi `(removed, CR-xx)` thay vì xóa, để link cũ vẫn có
nghĩa.

| ID | Meaning | Defined in |
|---|---|---|
| `Q-001` | Câu hỏi | questions.md |
| `A-001` | Assumption | questions.md |
| `US-001` | User story | stories.md |
| `UC-001` | Use case | requirements.md |
| `QA-001` | Quality attribute scenario | requirements.md |
| `BR-001` | Business rule | domain.md |
| `EC-001` | Edge case | domain.md |
| `SCR-001` | Màn hình | ui-flow.md |
| `TC-001` | Test case thủ công | testing.md |
| `ADR-0001` | Quyết định kiến trúc | decisions/ |
| `CR-42` | Change request, theo số Issue | Tracker |

## Diagrams

- Sơ đồ viết bằng Mermaid trong Markdown: GitHub render được, agent đọc và sửa được, và thay đổi hiện rõ trong diff.
- Mỗi sơ đồ nằm trong tài liệu sở hữu nó và có bảng hoặc đoạn văn đi kèm. Loại sơ đồ cho từng việc ghi ở mục Diagrams
  của [design.md](design.md).
- Sơ đồ không phải nguồn duy nhất của thông tin: chi tiết như quyền, timeout hay luật nằm trong bảng.

## Writing

Viết cho người không có mặt lúc thảo luận, kể cả chính mình sáu tháng sau: đọc xong phải biết đã chốt gì, vì sao, và
làm tiếp thế nào.

- Một câu một ý. Ghi điều kiện cụ thể: khi nào, bao nhiêu, ở đâu. Yêu cầu có ngoại lệ thì ghi ngoại lệ ngay cạnh.
- Giữ nguyên thuật ngữ kỹ thuật tiếng Anh thông dụng, như API, commit, aggregate, invariant. Thuật ngữ ít gặp thì giải
  thích ở lần xuất hiện đầu.
- Dùng bảng để so sánh, bullet cho các ý độc lập, đoạn văn để giải thích lý do.
- Phân biệt điều đã kiểm chứng, mục tiêu và assumption. Ghi nguồn và ngày cho thông tin lấy từ người dùng hoặc từ kết
  quả chạy.

| Unclear | Clearer |
|---|---|
| Hệ thống phải nhanh. | Mở lịch tuần của một phòng khi có 50 người dùng cùng lúc: p95 < 500 ms (QA-001). |
| Kiểm tra trùng lịch cẩn thận. | DB từ chối lịch chồng giờ trên cùng phòng bằng exclusion constraint (BR-001, ADR-0004). |
| Sẽ cân nhắc dùng cache sau. | Chưa dùng cache. Xem lại khi p95 của QA-001 vượt 400 ms ở hai lần đo liên tiếp (ADR-0006, Revisit when). |
| Đã test, chạy ổn. | `make check` xanh ở local; chưa thử trên staging. |
