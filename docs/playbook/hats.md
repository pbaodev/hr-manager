# Hats

Một người giữ mọi việc, nhưng mỗi lúc chỉ đội một mũ. Mũ tách câu hỏi "làm gì" khỏi "làm thế nào", và "làm thế nào"
khỏi "đã xong chưa". Phần lớn lỗi thiết kế trong dự án một người đến từ việc vừa phân tích vừa nghĩ tới framework, hoặc
vừa code vừa sửa yêu cầu cho khớp với code.

## Hats and decisions

| Hat | Owns | Decides | Phase |
|---|---|---|---|
| Analyst | Brief, questions, requirements, stories, domain, UI flow, user guide | `Go`/`Pivot`/`Stop`, phạm vi, priority, nghiệm thu | 1, 2, Feature loop |
| Architect | ARCHITECTURE, `design/`, contract, ADR, SPEC, conventions | Architecture style, stack, data model, contract | 3, Feature loop, 5 |
| Developer | Code, test, testing, task trên tracker | Cách hiện thực bên trong phạm vi SPEC | 4 |
| Ops | CI, setup, staging, deploy, backup, runbook, CHANGELOG, handover, secret | Phát hành, rollback | 0, 4, 5 |

## Switching hats

- Đội mũ nào thì chỉ sửa tài liệu của mũ đó. Đang code mà thấy yêu cầu thiếu thì ghi `Q-xxx` hoặc mở Issue, rồi đổi
  sang Analyst để sửa requirements; không sửa ngầm trong code.
- Đang code mà thấy thiết kế không ổn thì đổi sang Architect: sửa thiết kế, và viết ADR nếu khó đảo ngược, trong cùng
  PR hoặc PR trước đó. Không để code và thiết kế lệch nhau.
- Đội mũ Analyst thì không chọn công nghệ. Ý tưởng kỹ thuật nảy ra lúc đó ghi vào một Issue để xem ở Phase 3.
- Đội mũ Developer thì không nới acceptance criteria cho dễ làm. Muốn đổi thì quay lại mũ Analyst và đi theo
  [change-control.md](change-control.md).

## Self-review

Không có người thứ hai thì thay review chéo bằng ba lớp:

| Layer | How | Required for |
|---|---|---|
| Review nguội | Để ít nhất một đêm, rồi đọc lại theo checklist như thể người khác viết | Tài liệu chuyển sang `Accepted`; ADR; PR rủi ro cao |
| AI phản biện | Giao AI vai reviewer với câu hỏi cụ thể, như các câu ở cuối trang | Như trên, cộng mọi PR |
| Người ngoài | Bạn bè, mentor hoặc cộng đồng đọc ADR hay thiết kế quan trọng | Khi có thể |

- Ghi ngày review nguội, và AI hay người nào đã review, vào dòng **Reviewed** của tài liệu.
- Không hạ acceptance criteria, ngưỡng quality attribute hay ngưỡng eval để công việc được coi là xong.
- AI review không thay được việc tự đọc lại. AI dễ đánh giá cao một tài liệu có cấu trúc đẹp mà nội dung sai.

## AI by hat

AI agent hỗ trợ ở mọi mũ nhưng không đội mũ nào: người quyết định và chịu trách nhiệm.

| Hat | AI helps | AI does not |
|---|---|---|
| Analyst | Soạn câu hỏi cho người dùng; gợi edge case; chỉ ra acceptance criteria không kiểm được; chuyển ghi chú thành user story | Tự đặt ra luật nghiệp vụ. Luật AI gợi ý ghi `Assumed` cho tới khi có nguồn |
| Architect | Liệt kê phương án và trade-off theo quality attribute; phản biện ADR; vẽ sơ đồ Mermaid; đi thử một luồng trên thiết kế | Chọn stack hay thêm dịch vụ khi chưa có ADR |
| Developer | Viết code và test trong phạm vi task; review diff | Đổi contract, schema, SPEC hay tài liệu thiết kế ngoài phạm vi task |
| Ops | Viết CI, script, runbook nháp | Deploy production; đọc hay sửa secret |

Câu hỏi phản biện hay dùng:

- "Đọc stories, requirements và domain. Liệt kê những câu một developer sẽ phải hỏi trước khi code được US-003."
- "Tìm edge case cho UC-002 mà domain chưa có. Mỗi ca ghi tình huống và vì sao nó có thể xảy ra."
- "Acceptance criteria nào trong requirements không kiểm được bằng test hay thử tay? Viết lại cho kiểm được."
- "Đóng vai reviewer khó tính cho ADR-0004: phương án nào chưa được xét, hệ quả nào chưa ghi?"
- "Đi qua US-005 trên sequence diagram và API trong `docs/design/`. Chỉ ra bước nào thiếu dữ liệu, thiếu kiểm quyền
  hoặc thiếu xử lý lỗi."
