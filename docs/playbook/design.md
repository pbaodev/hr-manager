# Design

Design trả lời ba câu: hệ thống gồm những phần nào, dữ liệu được lưu và đi qua các phần đó thế nào, mỗi quyết định khó
đảo ngược được chọn vì sao. Đầu vào là output của Analysis. Kết quả ghi ở [ARCHITECTURE.md](../../ARCHITECTURE.md),
[`docs/design/`](../design/components.md), [ADR](../decisions/README.md) và [SPEC](../build/SPEC.md).

## Workflow

| Step | From analysis | Output | Recorded in |
|---|---|---|---|
| 1 Context | Actor, hệ thống ngoài | C4 Context | ARCHITECTURE: Context |
| 2 Drivers | Quality attribute `H/H`, `H/M`; ràng buộc trong brief | Driver và tactic | ARCHITECTURE: Architecture drivers |
| 3 Style and stack | Drivers | ADR | decisions |
| 4 Containers | Drivers, actor | C4 Container | ARCHITECTURE: Containers |
| 5 Data | Entity, aggregate, vòng đời, `BR-xxx` | ERD, constraint, index | [data](../design/data.md) |
| 6 API | Story, ma trận phân quyền | Operation, lỗi, contract | [api](../design/api.md), `contracts/openapi.yaml` |
| 7 Components | Story, `BR-xxx` | C4 Component, dependency rule | [components](../design/components.md) |
| 8 UI | UI flow, quality attribute về usability và accessibility | Design system, trạng thái màn hình, định dạng | [ui](../design/ui.md) |
| 9 Flows | Use case, story `Must` | Sequence diagram | [flows](../design/flows.md) |
| 10 Cross-cutting | Quality attribute về bảo mật, sensitive data | Cách làm cho từng concern, threats | ARCHITECTURE: Cross-cutting concerns, Threats |
| 11 AI | Story có tính năng AI | Component AI | [ai](../design/ai.md) |
| 12 SPEC | Toàn bộ | Module map, Traceability | SPEC |
| 13 Review | — | Design review checklist | Dòng Reviewed của từng tài liệu |

Thứ tự này là gợi ý. Bước 5–9 thường đi vòng vài lần: vẽ sequence diagram hay lộ ra field còn thiếu trong dữ liệu
hoặc operation còn thiếu trong API.

## C4 model

| Level | Shows | Recorded in |
|---|---|---|
| 1 Context | Hệ thống là một hộp; actor và hệ thống ngoài xung quanh | ARCHITECTURE.md |
| 2 Container | Thứ chạy hoặc lưu dữ liệu riêng: frontend, backend, DB, hàng đợi; cách chúng giao tiếp | ARCHITECTURE.md |
| 3 Component | Module bên trong một container và phụ thuộc giữa chúng | `design/components.md` |
| 4 Code | Class, function | Không vẽ; code là nguồn |

- Container trong C4 không phải Docker container mà là một đơn vị chạy hoặc lưu dữ liệu riêng.
- Mỗi hộp ghi tên, loại hoặc công nghệ, và một câu về trách nhiệm. Mỗi mũi tên ghi việc gì được trao đổi, và giao thức
  khi đã chọn.

## Diagrams

Sơ đồ viết bằng Mermaid trong Markdown, đặt trong tài liệu sở hữu nó; nơi khác dẫn link.

| Diagram | Mermaid type | Used in |
|---|---|---|
| C4 Context, Container, Component | `flowchart` | ARCHITECTURE, components |
| Domain model | `classDiagram` | domain |
| Lifecycle | `stateDiagram-v2` | domain |
| Data model | `erDiagram` | data |
| Flow | `sequenceDiagram` | flows |
| UI flow | `flowchart` | ui-flow |

- Sơ đồ cho cái nhìn tổng; bảng đi kèm giữ chi tiết. Agent và lệnh tìm kiếm đọc bảng dễ hơn đọc sơ đồ.
- Cú pháp C4 riêng của Mermaid còn ở dạng experimental. Dùng `flowchart` và ghi loại trong ngoặc vuông ở nhãn, ví dụ
  `"api<br/>[HTTP service]"`.

## Architecture drivers and tactics

Driver là quality attribute đứng đầu (`H/H`, `H/M`) cộng các ràng buộc. Mỗi driver có ít nhất một tactic, tức một cách
thiết kế cụ thể để đáp ứng nó. Tactic khó đảo ngược thì có ADR.

| Attribute | Common tactics |
|---|---|
| Performance | Index theo truy vấn; phân trang; cache dữ liệu đọc nhiều; chuyển việc chậm sang job nền |
| Availability | Timeout và retry có giới hạn cho lời gọi ra ngoài; hàng đợi cho việc không cần làm ngay; backup và runbook khôi phục |
| Data integrity | Constraint trong DB; transaction theo aggregate; idempotency key; optimistic locking |
| Security | Kiểm quyền ở backend cho mọi operation; validate đầu vào ở biên; quyền tối thiểu cho key và DB user; secret ngoài repo |
| Modifiability | Module theo feature; dependency rule một chiều; contract giữa module; config thay vì hard-code |
| Cost | Scale-to-zero; managed service ở gói miễn phí; giới hạn chi tiêu; gom việc thành batch |
| Testability | Domain logic không phụ thuộc framework hay DB; dịch vụ ngoài nằm sau interface để mock |

Tactic hay xung đột với nhau, ví dụ cache tăng performance nhưng làm khó việc giữ dữ liệu nhất quán. Trade-off ghi vào
ADR.

## Architecture style

Default là modular monolith: một ứng dụng, deploy một lần, chia module theo feature với ranh giới rõ. Một người khó
gánh chi phí vận hành nhiều service, và ranh giới module tốt vẫn cho phép tách service về sau. Chọn style nào cũng ghi
ADR.

| Style | Fits when | Watch out |
|---|---|---|
| Modular monolith | Default; hầu hết dự án một người | Ranh giới module chỉ giữ được khi có dependency rule và cách kiểm |
| Client + BaaS | App chủ yếu CRUD, cần ra nhanh; BaaS lo auth, DB, storage | Luật nghiệp vụ dễ rơi xuống client; cần luật ở DB hoặc function phía server |
| Serverless functions | Tải không đều, cần scale-to-zero | Cold start; khó chạy local; trạng thái phải nằm ngoài function |
| Microservices | Hiếm khi có lý do khi làm một mình | Chi phí vận hành, nhất quán dữ liệu giữa service, debug phân tán |

## Data design

| Domain | Data |
|---|---|
| Entity | Bảng hoặc collection có khóa riêng |
| Value object | Cột, nhóm cột hoặc kiểu riêng (range, money); JSON khi không cần truy vấn bên trong |
| Aggregate | Ranh giới transaction: một lần cập nhật chỉ đụng một aggregate |
| Invariant trong aggregate | Constraint DB khi biểu diễn được (`NOT NULL`, `UNIQUE`, `CHECK`, khóa ngoại); còn lại kiểm ở domain |
| Luật trải trên nhiều aggregate | Constraint DB (exclusion, unique), khóa, hoặc xử lý bất đồng bộ có bù trừ; chọn kèm ADR |
| Lifecycle | Cột trạng thái với tập giá trị cố định; chuyển trạng thái kiểm ở domain |
| Parameters | Config, không phải hằng số trong code |

- Liệt kê các truy vấn chính từ story rồi mới chọn index. Không thêm index "phòng khi cần".
- Khi đã có dữ liệu thật, migration phải tương thích ngược: thêm cấu trúc mới, chuyển dữ liệu, rồi mới bỏ cấu trúc cũ.
- Lưu thời gian theo UTC; giữ timezone riêng khi cần hiển thị theo giờ địa phương.

## API design

- Mỗi việc actor làm trong story thành một operation; resource lấy từ entity.
- Contract-first: viết contract trước code, rồi sinh type cho client từ contract. Default là OpenAPI ở
  `contracts/openapi.yaml`; CI lint bằng job `contract`. Ví dụ trong file dùng chung hệ thống đặt phòng của template.
- Lỗi có format chung và mã lỗi theo nghĩa nghiệp vụ, ví dụ `booking_conflict` dẫn tới `BR-001`. Client không phải đọc
  message để biết lỗi gì.
- Mỗi operation ghi actor và điều kiện được phép. Backend kiểm quyền kể cả khi giao diện đã ẩn nút.
- Operation tạo mới hoặc có tác động ra ngoài cần idempotency khi client có thể gửi lặp.
- Thay đổi không tương thích (bỏ field, đổi nghĩa field, thêm field bắt buộc) là thay đổi loại Interface theo
  [change-control.md](change-control.md).

## Components and dependency rules

Chia theo feature trước, rồi theo tầng bên trong mỗi feature. Default là ports and adapters ở dạng gọn:

```text
  http, cli, jobs ──▶ application ──▶ domain
                          ▲
  persistence, clients ───┘   hiện thực interface do application định nghĩa
```

- **domain** không import framework, DB hay HTTP. Domain giữ entity, value object, invariant và business rule; test
  domain không cần DB.
- **application** điều phối một use case: tải aggregate, gọi domain, lưu, phát sự kiện.
- **Adapter** (http, persistence, client của dịch vụ ngoài) phụ thuộc vào trong, không theo chiều ngược lại.
- Module này dùng module kia qua interface public, không đọc bảng của nhau.
- Kiểm dependency rule bằng công cụ khi stack có, ví dụ import-linter, dependency-cruiser, ArchUnit. Không có thì đưa
  vào checklist review.
- App nhỏ, chủ yếu CRUD: gộp application và domain, nhưng giữ quy tắc "luật nghiệp vụ không nằm trong route handler".

## Flows

- Mỗi luồng chính và mỗi use case có một sequence diagram. Participant là container hoặc component, không phải class.
- Vẽ nhánh lỗi quan trọng bằng `alt`; ghi transaction bắt đầu và kết thúc ở đâu.
- Mỗi lời gọi ra ngoài có timeout, retry và hành vi khi không có phản hồi. Phân biệt lỗi thử lại được với thao tác đã
  có tác động mà chưa biết thành công hay chưa, như gửi email hay thanh toán. Loại thứ hai không retry tự động.
- **Walkthrough:** đi qua từng bước của use case trên sơ đồ. Bước nào cần dữ liệu chưa có trong data model, operation
  chưa có trong API, hay quyền chưa được kiểm ở đâu là một lỗ hổng thiết kế.

## Cross-cutting concerns

Ghi cách làm cho từng concern ở ARCHITECTURE.md; bỏ dòng không áp dụng.

| Concern | Questions to answer |
|---|---|
| Authentication | Đăng nhập bằng gì; phiên sống bao lâu; token lưu ở đâu |
| Authorization | Mô hình quyền (theo vai, theo chủ sở hữu); kiểm ở tầng nào; dữ liệu nào lọc theo người xem |
| Validation | Kiểm đầu vào ở biên nào; lỗi validation trả về ra sao |
| Errors | Lỗi nào báo người dùng, lỗi nào chỉ ghi log; lỗi không lường trước trả về gì |
| Logging and monitoring | Ghi gì; không ghi gì (dữ liệu nhạy cảm, secret); xem ở đâu |
| Configuration and secrets | Config nằm ở đâu và khác nhau giữa môi trường thế nào; secret lưu và xoay vòng ra sao |
| Time | Lưu theo UTC; hiển thị theo timezone nào; "hôm nay" tính theo đâu |
| Background jobs | Việc nào chạy nền; chạy lại có an toàn không; ai thấy job lỗi |
| Files | Lưu ở đâu; giới hạn kích thước và loại file; ai tải được |

## Design depth by risk

| Area | Design carefully before code when | Let code decide when |
|---|---|---|
| Data model | Có dữ liệu thật, migration khó, có luật nhất quán | Bảng phụ, dữ liệu dựng lại được |
| API contract | Client khác repo hoặc hệ thống khác dùng | Một client nội bộ, cùng repo, deploy cùng lúc |
| Auth và quyền | Luôn | — |
| Luồng có tiền, xóa dữ liệu, gửi ra ngoài | Luôn | — |
| Module nội bộ | Nhiều feature phụ thuộc vào nó | Chỉ một feature dùng |
| Giao diện | Luồng nhiều bước, nhiều trạng thái | Màn hình chỉ hiển thị |

## ADRs

- Viết ADR khi quyết định khó hoặc tốn công để đổi lại: architecture style, stack, DB, auth, hosting, cách đáp ứng một
  driver, contract mà bên ngoài dùng.
- Có ít nhất hai phương án thật. Cột Fit with drivers so các phương án theo quality attribute thay vì theo sở thích.
- Mục Revisit when ghi điều kiện khiến quyết định cần xem lại. Phase 5 kiểm mục này ở mỗi milestone.
- Đổi quyết định thì viết ADR mới; ADR cũ chuyển sang `Superseded by ADR-NNNN`. Mẫu ở
  [decisions/_template.md](../decisions/_template.md).

## Design review checklist

Dùng khi review nguội và khi giao AI phản biện. Ở Feature loop, chỉ chạy các dòng liên quan tới phần delta.

- [ ] Mỗi architecture driver có tactic trong ARCHITECTURE; tactic khó đảo ngược có ADR `Accepted`.
- [ ] Mọi actor và hệ thống ngoài trong requirements có mặt trên sơ đồ Context.
- [ ] Mỗi entity trong domain có trong data model, hoặc có ghi lý do không lưu.
- [ ] Mỗi `BR-xxx` có nơi giữ (constraint DB, domain hoặc validation ở API), ghi trong `data.md` hoặc `components.md`.
- [ ] Mỗi story `Must` có operation trong API hoặc interface tương đương, kèm actor và quyền.
- [ ] Mỗi use case và luồng chính có sequence diagram; walkthrough không lộ ra dữ liệu, operation hay bước kiểm quyền
      còn thiếu.
- [ ] Mỗi lời gọi ra ngoài có timeout, retry và hành vi khi lỗi.
- [ ] Mỗi loại dữ liệu nhạy cảm trong domain có dòng trong Data and trust boundaries.
- [ ] Mỗi mối đe dọa trong Threats có biện pháp và nơi giữ biện pháp đó.
- [ ] Mỗi operation trong api.md có trong contract; check `contract` xanh.
- [ ] Có giao diện: `design/ui.md` có trạng thái màn hình và accessibility target; mỗi mã lỗi người dùng thấy có câu
      thông báo.
- [ ] Dependency rule rõ ràng, không có vòng phụ thuộc giữa module, và có cách kiểm.
- [ ] Mỗi container và component truy được về story, driver hoặc ràng buộc.
- [ ] Traceability trong SPEC phủ mọi story `Must` và mọi driver; màn hình, operation và luật trong bảng khớp với
      ui-flow, api và data.
- [ ] Có ADR cho architecture style, stack, lưu trữ dữ liệu, auth và hosting.
