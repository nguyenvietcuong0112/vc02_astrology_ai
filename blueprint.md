# Bản Kế Hoạch (Blueprint)

## Tổng Quan

Đây là một ứng dụng Flutter nhằm cung cấp các lá số tử vi được cá nhân hóa cho người dùng. Ứng dụng sử dụng API Gemini để tạo lá số, đồng thời tích hợp các tính năng như lịch sử xem, ghi chú cá nhân và một thư viện kiến thức chiêm tinh, tạo ra một trải nghiệm toàn diện và có chiều sâu.

## Các Tính Năng Đã Hoàn Thành

-   **Nhập và Lưu Thông Tin:** Người dùng có thể nhập ngày, giờ, nơi sinh và thông tin này được lưu lại cho các lần sử dụng sau.
-   **Luận Giải Tử Vi bằng AI:** Sử dụng API Gemini để tạo lá số tử vi cá nhân hóa (cả dạng tiêu chuẩn và cao cấp).
-   **Giao Diện Tùy Chỉnh:** Hỗ trợ giao diện sáng (light) và tối (dark), cùng khả năng chuyển đổi ngôn ngữ (Việt/Anh).
-   **Chia Sẻ:** Người dùng có thể chia sẻ lá số của mình.
-   **Xác thực & Thông báo:** Tự động đăng nhập ẩn danh và thiết lập nhận thông báo đẩy qua FCM.
-   **Kiến trúc & Điều hướng:** Tái cấu trúc ứng dụng với kiến trúc rõ ràng, sử dụng `StatefulWidget` cho các màn hình và `BottomNavigationBar` để điều hướng giữa các tính năng chính (Trang chủ, Lịch sử, Thư viện).
-   **Lịch sử Xem Tử Vi:** Người dùng có thể xem lại danh sách các lá số đã tạo trước đây, được lưu trữ cục bộ bằng `sqflite`.

## Cấu Trúc Dự Án

-   `lib/main.dart`: Điểm khởi đầu của ứng dụng, quản lý các provider (Theme, Language).
-   `lib/src/app/main_screen.dart`: Widget chính chứa `BottomNavigationBar` và quản lý các màn hình con.
-   `lib/src/core/router/app_router.dart`: (Không còn sử dụng) Điều hướng hiện được quản lý bởi `MainScreen`.
-   `lib/src/core/theme/app_theme.dart`: Định nghĩa giao diện sáng/tối.
-   `lib/src/features/horoscope/services/ai_horoscope_service.dart`: Chứa hàm gọi API Gemini.
-   `lib/src/features/horoscope/ui/horoscope_home_page.dart`: Màn hình chính (tab Trang chủ).
-   `lib/src/features/history/services/database_helper.dart`: Lớp quản lý cơ sở dữ liệu `sqflite`.
-   `lib/src/features/history/ui/history_page.dart`: Màn hình hiển thị lịch sử (tab Lịch sử).
-   `lib/src/features/library/ui/library_page.dart`: Màn hình chờ cho Thư viện.
-   `l10n.yaml` & `lib/l10n/`: Cấu hình và tệp bản dịch cho đa ngôn ngữ.

---

## Nhiệm Vụ Tiếp Theo: Tích hợp Ghi Chú Cá Nhân

**Mục tiêu:** Cho phép người dùng thêm các suy nghĩ, ghi chép cá nhân vào mỗi lá số, biến ứng dụng thành một cuốn nhật ký chiêm tinh. Tính năng này sẽ làm tăng sự gắn kết và cá nhân hóa trải nghiệm.

### Kế hoạch triển khai:

1.  **Cập nhật Cơ sở dữ liệu:**
    -   Sửa đổi bảng `horoscopes` trong `database_helper.dart` để thêm một cột mới: `notes TEXT`.
    -   Cần một phương thức để xử lý việc nâng cấp cơ sở dữ liệu (từ version 1 lên 2) để không làm mất dữ liệu cũ của người dùng.

2.  **Cập nhật Giao diện người dùng (UI):**
    -   **Trong màn hình Chi tiết Tử Vi (khi xem từ Lịch sử):**
        -   Thêm một khu vực để hiển thị ghi chú đã lưu.
        -   Thêm một nút (ví dụ: `Icon(Icons.edit)`) để cho phép người dùng thêm hoặc chỉnh sửa ghi chú.
        -   Khi nhấn nút sửa, hiển thị một `AlertDialog` hoặc `TextField` cho phép người dùng nhập văn bản.
    -   **Lưu Ghi chú:** Khi người dùng lưu ghi chú, tạo một hàm trong `DatabaseHelper` để cập nhật bản ghi tương ứng trong cơ sở dữ liệu.

3.  **Làm mới Giao diện:** Sau khi lưu ghi chú, tự động làm mới lại màn hình chi tiết để hiển thị ghi chú mới.

## Kế Hoạch Tương Lai

-   **Tính năng: Thư viện Chiêm tinh**
    -   **Mục tiêu:** Cung cấp kiến thức, giúp người dùng hiểu sâu hơn về chiêm tinh.
    -   **Phần A: Giải thích Thuật ngữ Chiêm tinh:** Tạo màn hình tra cứu thuật ngữ, sử dụng AI để giải thích.
    -   **Phần B: Xem độ hợp cung hoàng đạo:** Tạo màn hình cho phép người dùng chọn 2 cung và xem phân tích độ hợp từ AI.
