import axios from "axios"
import { useEffect, useState } from "react"

export default function WaitPayment(props) {

    const [data, setData] = useState([])

    const GetCreatedBooking = async () => {
        // event.preventDefault();
        await axios
            .get(process.env.REACT_APP_SERVER_HOST + "Guest/GetCreateTimeBook")
            .then((result) => {
                // let arr = [];
                // result.data.map((item) => arr.push(item.startTime));
                setData(result.data);
            })
            .catch((err) => { console.log(err) });

    };

    const handleCancelBooking = (bookingId) => {
        var user = JSON.parse(sessionStorage.getItem('user'))
        const url = process.env.REACT_APP_SERVER_HOST + 'Guest/CancelBooking';
        axios.put(url, {
            bookingId: bookingId,
            userId: user.userId
        }, {
            headers: {
                accept: 'application/json'
            }
        })
            .then(function (response) {
                props.setTableData(response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
    }

    // fetching data
    useEffect(() => {
        GetCreatedBooking();
    }, [])

    useEffect(() => {
        // console.log(data, 'useEffect');

        for (let index = 0; index < data.length; index++) {
            const element = data[index].startTime;

            const date = new Date(element);
            const mileSeconds = date.getTime()

            // Nếu chưa có thời gian bắt đầu, tạo mới và lưu vào localStorage
            localStorage.setItem("startTime_" + index, mileSeconds);
            // Khởi tạo biến lưu trữ thời gian bắt đầu
            var startTime = localStorage.getItem("startTime_" + index);

            // Khởi tạo biến lưu trữ thời gian chờ thanh toán (ví dụ 60 phút)
            var timeout = 60 * 60 * 1000; // tính bằng mili giây
            // Hàm kiểm tra thời gian chờ thanh toán
            function checkPaymentTimeout() {
                // Lấy thời gian hiện tại
                var currentTime = new Date().getTime();
                // console.log(currentTime);
                // Tính thời gian đã trôi qua kể từ lần bắt đầu
                var elapsed = currentTime - startTime
                // console.log('Time out: ', timeout);
                // console.log('Elapsed: ', elapsed);
                // console.log('Current Time: ', currentTime);
                // console.log('Start Time: ', startTime);

                // Nếu thời gian đã trôi qua lớn hơn hoặc bằng thời gian chờ thanh toán
                if (elapsed >= timeout) {
                    // Xóa giá trị startTime khỏi localStorage
                    localStorage.removeItem("startTime_" + index);
                    // Thực hiện hành động khi hết thời gian chờ thanh toán
                    // alert("Hết thời gian thanh toán")
                    handleCancelBooking(data[index].bookingId)

                } else {
                    // Nếu chưa hết thời gian chờ thanh toán, tính lại khoảng còn lại
                    var remaining = timeout - elapsed;
                    // console.log("Remaining: startTime_" + index, remaining);
                    // Gọi lại hàm kiểm tra sau khoảng còn lại
                    setTimeout(checkPaymentTimeout, remaining);
                }
            }
            // Gọi hàm kiểm tra lần đầu tiên khi load trang
            checkPaymentTimeout();
        }
    });



    return (
        <>
            {/* WaitPayment Time out */}
        </>
    )
}