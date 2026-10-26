
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Dairy | Payments</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f0f7f4;
    color: #263b33;
}

.header {
    background: #176b55;
    color: white;
    padding: 22px 30px;
}

.header h1 {
    margin: 0;
    font-size: 25px;
}

.header p {
    margin: 7px 0 0;
    color: #d9f3e8;
}

.container {
    max-width: 850px;
    margin: 35px auto;
    padding: 0 18px;
}

.card {
    background: white;
    padding: 28px;
    border-radius: 14px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}

.card h2 {
    margin-top: 0;
    color: #176b55;
}

.grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
}

.field {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-bottom: 17px;
}

.field.full {
    grid-column: 1 / -1;
}

label {
    font-weight: 600;
    font-size: 14px;
}

input, select, textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #cbdcd4;
    border-radius: 7px;
    font-size: 14px;
    background: #fff;
}

input:focus, select:focus, textarea:focus {
    outline: 2px solid #9bd6bd;
    border-color: #176b55;
}

textarea {
    min-height: 85px;
    resize: vertical;
}

button {
    border: none;
    background: #176b55;
    color: white;
    padding: 13px 22px;
    border-radius: 7px;
    cursor: pointer;
    font-size: 15px;
    font-weight: bold;
}

button:hover {
    background: #10513f;
}

.back {
    display: inline-block;
    margin-bottom: 18px;
    color: #176b55;
    text-decoration: none;
    font-weight: bold;
}

.message {
    padding: 12px;
    border-radius: 7px;
    margin-bottom: 18px;
    background: #e8f5e9;
    color: #216e39;
}

.error {
    background: #ffebee;
    color: #b71c1c;
}

@media (max-width: 600px) {
    .grid {
        grid-template-columns: 1fr;
    }

    .field.full {
        grid-column: auto;
    }

    .card {
        padding: 20px;
    }
}
</style>
</head>

<body>

<div class="header">
    <h1>Smart Dairy</h1>
    <p>Payment Management System</p>
</div>

<div class="container">

    <a class="back" href="<%= request.getContextPath() %>/dashboard.jsp">
        &larr; Back to Dashboard
    </a>

    <div class="card">
        <h2>Record a Payment</h2>
        <p>Enter the customer and payment details below.</p>

        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="message">Payment recorded successfully.</div>
        <% } %>

        <% if (request.getParameter("error") != null) {
            String error = request.getParameter("error");
            String message = "Unable to process payment. Please check the details.";

            if ("missing".equals(error)) {
                message = "Please fill in all required fields.";
            } else if ("invalid".equals(error) || "amount".equals(error)) {
                message = "Enter valid customer, order and amount details.";
            } else if ("order".equals(error)) {
                message = "Order not found for this customer.";
            } else if ("excess".equals(error)) {
                message = "Payment exceeds the pending order amount.";
            } else if ("database".equals(error) || "true".equals(error)) {
                message = "Database error while saving payment. Check the server log.";
            }
        %>
            <div class="message error"><%= message %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/PaymentServlet"
              method="post">

            <div class="grid">

                <div class="field">
                    <label for="customer_id">Customer ID *</label>
                    <input type="number" id="customer_id"
                           name="customer_id" min="1" required>
                </div>

                <div class="field">
                    <label for="order_id">Order ID</label>
                    <input type="number" id="order_id"
                           name="order_id" min="1"
                           placeholder="Optional">
                </div>

                <div class="field">
                    <label for="payment_date">Payment Date *</label>
                    <input type="date" id="payment_date"
                           name="payment_date" required>
                </div>

                <div class="field">
                    <label for="amount">Amount (₹) *</label>
                    <input type="number" id="amount" name="amount"
                           min="0.01" step="0.01" required>
                </div>

                <div class="field">
                    <label for="payment_method">Payment Method *</label>
                    <select id="payment_method" name="payment_method" required>
                        <option value="">Select method</option>
                        <option value="CASH">Cash</option>
                        <option value="UPI">UPI</option>
                        <option value="BANK_TRANSFER">Bank Transfer</option>
                        <option value="CARD">Card</option>
                        <option value="CHEQUE">Cheque</option>
                    </select>
                </div>

                <div class="field">
                    <label for="transaction_reference">
                        Transaction Reference
                    </label>
                    <input type="text" id="transaction_reference"
                           name="transaction_reference"
                           maxlength="150"
                           placeholder="UPI reference or transaction ID">
                </div>

                <div class="field full">
                    <label for="remarks">Remarks</label>
                    <textarea id="remarks" name="remarks"
                              placeholder="Optional payment notes"></textarea>
                </div>

            </div>

            <button type="submit">Save Payment</button>
        </form>
    </div>
</div>

<script>
document.getElementById("payment_date").value =
    new Date().toLocaleDateString("en-CA");
</script>

</body>
</html>

