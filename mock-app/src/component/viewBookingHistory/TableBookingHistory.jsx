import { React, useState, useEffect } from 'react';
import {
    Table,
    Typography,
    Button,
    Tooltip,
    Timeline,
    Card,
    Modal
} from 'antd';
import {
    ClockCircleOutlined,
    LoginOutlined,
    LogoutOutlined,
    CreditCardOutlined,
    WalletOutlined,
    ExclamationCircleFilled,
    DeleteOutlined,
    HomeOutlined
} from '@ant-design/icons';
import axios from 'axios';
import '../../assests/css/viewBookingHistory.css'
import dayjs from 'dayjs';

//#region CONSTANT
const { Title } = Typography;

const { confirm } = Modal;

const customTooltip = (data) => {
    return (
        <Card
            style={{
                width: '400px',
            }}
            title="Booking Details"
            key={data.key}
        >
            <Timeline
                key={data.key}
                mode={'left'}
                items={[
                    {
                        children: data.bookingDate,
                        label: 'Booking Date',
                        dot: <ClockCircleOutlined />,
                        color: 'blue'
                    },
                    {
                        children: data.checkIn,
                        label: 'Your check-in date',
                        dot: <LoginOutlined />,
                        color: 'orange',
                    },
                    {
                        children: data.checkOut,
                        label: 'Your check-out date',
                        dot: <LogoutOutlined />,
                        color: 'purple',
                    },
                    {
                        label: 'Booking status',
                        children: data.status == "0" ? ((data.priceGap == null || data.priceGap == 0) ? "UnPaid" : "Unpaid (Please pay the remaining " + data.priceGap + "$)") : data.status == "1" ? "Paid" : "Canceled",
                        dot: <WalletOutlined />,
                        color: 'yellow',
                    },
                    {
                        label: 'Rooms',
                        children: data.listRooms.map((room) => {
                            return <div>{room.roomInfo.roomName}</div>;
                        }),
                        dot: <HomeOutlined />,
                        color: 'Red',
                    }
                ]}
            />
        </Card>
    );
};
//#endregion

const TableBookingHistory = (props) => {
    const [listBookingDates, setListBookingDates] = useState([]);

    //#region SHOW CONFIRM REGION
    const showConfirm = (bookingId) => {
        confirm({
            title: 'Are you sure to cancel this booking? If canceled, the paid money will not refund!',
            icon: <ExclamationCircleFilled />,
            onOk() {
                handleCancelBooking(bookingId);
            },
            onCancel() {
                console.log('Cancel');
            },
        });
    };

    const showConfirmPay = (data) => {
        confirm({
            title: 'You will pay ' + data.totalPrice + " VND. Are you sure want to paid for this booking?",
            icon: <ExclamationCircleFilled />,
            onOk() {
                handlePayBooking(data);
            },
            onCancel() {
                console.log('Cancel');
            },
        });
    };
    //#endregion   

    //#region TABLE INITIATE
    const columns = [
        {
            title: 'Booking Date',
            dataIndex: 'bookingDate',
        },
        {
            title: 'Date Check-in',
            dataIndex: 'checkIn',
        },
        {
            title: 'Date Check-out',
            dataIndex: 'checkOut',
        },
        {
            title: 'Total Money ($)',
            dataIndex: 'totalPrice',
        },
        {
            title: 'Status',
            dataIndex: 'status',
            render: (_, record) =>
                record.status == "0" ? "UnPaid" : record.status == "1" ? "Paid" : "Canceled"
        },
        {
            title: 'Action',
            key: 'operation',
            render: (_, record) =>
                <>
                    {record.cancelAvailable ?
                        <Button
                            type='primary'
                            icon={<DeleteOutlined />}
                            danger
                            onClick={() => showConfirm(record.key)}
                        ></Button> : null}
                    {" "}
                    {
                        localStorage.getItem('startTime_' + record.key) != undefined && record.status == "0" ?
                            <Button
                                type='primary'
                                icon={<CreditCardOutlined />}
                                onClick={() => showConfirmPay(record)}
                            ></Button> : null
                    }
                </>
        },
    ];

    useEffect(() => {
        GetCreatedBooking();
    }, []);

    //this will call if mr.Phu want to auto cancel no need f5
    // useEffect(() => {
    //     if(listBookingDates.length > 0){
    //         GetCreatedBooking();
    //     }        
    // }, [listBookingDates]);   

    const GetCreatedBooking = async () => {
        await axios
            .get(process.env.REACT_APP_SERVER_HOST + "Guest/GetBookingDatesOfUser?userId=" + props.userId)
            .then((result) => {
                setListBookingDates(result.data);
            }).catch((err) => { console.log(err) });
    };

    useEffect(() => {
        for (let index = 0; index < listBookingDates.length; index++) {
            const element = listBookingDates[index].updateDate;
            const date = new Date(element);
            const mileSeconds = date.getTime();

            // Nếu chưa có thời gian bắt đầu, tạo mới và lưu vào localStorage
            localStorage.setItem("startTime_" + listBookingDates[index].bookingId, mileSeconds);

            // Khởi tạo biến lưu trữ thời gian bắt đầu
            var startTime = localStorage.getItem("startTime_" + listBookingDates[index].bookingId);

            // Khởi tạo biến lưu trữ thời gian chờ thanh toán (ví dụ 60 phút)
            var timeout = 60 * 60 * 1000; // tính bằng mili giây

            // Hàm kiểm tra thời gian chờ thanh toán
            checkPaymentTimeout(startTime, timeout, listBookingDates[index].bookingId);
        }
    });

    function checkPaymentTimeout(startTime, timeout, bookingId) {
        // Lấy thời gian hiện tại
        var currentTime = new Date().getTime();

        // Tính thời gian đã trôi qua kể từ lần bắt đầu
        var elapsed = currentTime - startTime

        // Nếu thời gian đã trôi qua lớn hơn hoặc bằng thời gian chờ thanh toán
        if (elapsed >= timeout) {
            // Xóa giá trị startTime khỏi localStorage
            localStorage.removeItem("startTime_" + bookingId);

            // Thực hiện hành động khi hết thời gian chờ thanh toán
            handleCancelBooking(bookingId);
        } else {
            // Nếu chưa hết thời gian chờ thanh toán, tính lại khoảng còn lại
            var remaining = timeout - elapsed;

            // Gọi lại hàm kiểm tra sau khoảng còn lại
            setTimeout(checkPaymentTimeout, remaining);
        }
    }

    const CustomRow = (properties) => {
        if (properties.children[0] != undefined) {
            let rowData = properties.children[0].props.record;
            let tooltip = customTooltip(rowData);
            return (
                <Tooltip title={tooltip} color={'#fff'} key={'#fff'} placement="topLeft">
                    <tr {...properties} />
                </Tooltip>
            );
        }
        return (<tr {...properties} />);
    }
    //#endregion

    const handleCancelBooking = (bookingId) => {
        const url = process.env.REACT_APP_SERVER_HOST + 'Guest/CancelBooking';
        axios.put(url, {
            bookingId: bookingId,
            userId: props.userId
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

    const handlePayBooking = (data) => {
        let booking_detail_data = {
            rooms: data.listRooms,
            date: [dayjs(data.checkIn), dayjs(data.checkOut)],
            totalPrice: data.totalPriceNotFormat,
            bookingId: data.key,
            type: 'Update'
        }

        const obj = encodeURIComponent(JSON.stringify(booking_detail_data));
        window.location.href = `/booking_detail?data=${obj}`;
    };

    return (
        <>
            <Title level={4}>Result</Title>
            <Table
                className='tbl-booking-history'
                columns={columns}
                dataSource={props.tableData}
                components={{
                    body: {
                        row: CustomRow
                    }
                }}
            />
        </>
    )
};

export default TableBookingHistory;