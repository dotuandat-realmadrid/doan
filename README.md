# Do an
Chức năng của các microservice này:
* Dịch vụ Người dùng (User Service)
    + Đăng ký & Đăng nhập: Quản lý tài khoản.
    + Xác thực (Authentication): Xử lý đăng nhập, tạo và quản lý token (JWT).
    + Phân quyền (Authorization): Quản lý vai trò (Admin, Khách hàng, ...) và quyền hạn truy cập.
* Dịch vụ Sản phẩm (Product Service)
    + Quản lý sản phẩm: Thêm, sửa, xóa thông tin, hình ảnh, giá cả sản phẩm.
    + Quản lý danh mục: Sắp xếp sản phẩm vào các danh mục.
    + Quản lý nhà cung cấp:
        - Lưu trữ thông tin chi tiết của các nhà cung cấp
        - Liên kết sản phẩm với nhà cung cấp tương ứng
        - Cho phép lọc sản phẩm theo nhà cung cấp.
    + Tìm kiếm & Lọc: Cung cấp API để tìm kiếm và lọc sản phẩm.
    + Đánh giá & Xếp hạng: Cho phép người dùng đánh giá sản phẩm đã mua.
* Dịch vụ Kho hàng (Inventory Service)
    + Quản lý tồn kho: Theo dõi số lượng thực tế của từng sản phẩm (SKU).
    + Cập nhật tự động: Tự động trừ kho khi có đơn hàng mới và cộng kho khi nhập hàng.
    + Quản lý nhập kho: Ghi nhận lịch sử nhập hàng mới từ nhà cung cấp.
* Dịch vụ Khuyến mãi (Discount Service)
    + Quản lý mã giảm giá (Coupons/Vouchers):
    + Tạo, sửa, xóa các mã giảm giá.
    + Thiết lập các loại giảm giá (theo %, theo số tiền cố định).
    + Định nghĩa điều kiện áp dụng (đơn hàng tối thiểu, cho sản phẩm/danh mục cụ thể, giới hạn số lần sử dụng).
    + Xác thực mã giảm giá: Cung cấp API cho Dịch vụ Đơn hàng để kiểm tra tính hợp lệ và áp dụng mã vào giỏ hàng.
* Dịch vụ Đơn hàng (Order Service)
    + Quản lý giỏ hàng: Thêm, xóa, cập nhật sản phẩm trong giỏ hàng.
    + Xử lý đặt hàng:
        - Tạo đơn hàng mới, thu thập thông tin giao hàng.
        - Tích hợp với Dịch vụ Khuyến mãi để áp dụng mã giảm giá vào tổng giá trị đơn hàng.
        - Tích hợp thanh toán vnpay cho đơn hàng và hoàn tiền đơn hàng.
    + Quản lý trạng thái đơn hàng: Theo dõi các trạng thái (chờ xác nhận, đang giao, đã giao, hủy, giao hàng thất bại).
    + Lịch sử mua hàng: Lưu lại lịch sử đơn hàng của người dùng.

## Tech stack
* Build tool: maven >= 3.9.5
* Java: 21
* Framework: Spring boot 3.2.x
* DBMS: MySQL

## Prerequisites
* Java SDK 21
* A MySQL server

## Start application
`mvn spring-boot:run`

## Build application
`mvn clean package`

## Docker guideline
### Build docker image
`docker build -t <account>/doan:0.0.1 .`
### Push docker image to Docker Hub
`docker image push <account>/doan:0.0.1`
### Create network:
`docker network create doan-network`
### Start MySQL in doan-network
`docker run --network doan-network --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:8.0.43`
### Run your application in doan-network
`docker run --name doan --network doan-network -p 8080:8080 -e DBMS_CONNECTION=jdbc:mysql://mysql:3306/doan doan:0.0.1`