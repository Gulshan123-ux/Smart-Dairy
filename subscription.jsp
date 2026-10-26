```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Dairy - Subscription Management</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f3f7f3;
    color: #26352a;
}

header {
    background: #2e7d32;
    color: white;
    padding: 20px 30px;
}

header h1 {
    margin: 0;
    font-size: 25px;
}

header p {
    margin: 7px 0 0;
}

.container {
    max-width: 950px;
    margin: 30px auto;
    padding: 0 16px;
}

.card {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
    margin-bottom: 22px;
}

h2 {
    color: #2e7d32;
    margin-top: 0;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 17px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 7px;
}

input, select, textarea {
    width: 100%;
    padding: 11px;
    border: 1px solid #cbd5cc;
    border-radius: 6px;
    font-size: 14px;
}

textarea {
    resize: vertical;
}

.full {
    grid-column: 1 / -1;
}

button {
    background: #2e7d32;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 12px 22px;
    cursor: pointer;
    font-size: 15px;
}

button:hover {
    background: #1b5e20;
}

.message {
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 18px;
}

.success {
    background: #e4f5e7;
    color: #1b5e20;
}

.error {
    background: #ffebee;
    color: #b71c1c;
}

.secondary {
    display: inline-block;
    color: #2e7d32;
    text-decoration: none;
    margin-left: 12px;
}

@media (max-width: 600px) {
    .form-grid {
        grid-template-columns: 1fr;
    }

    .full {
        grid-column: auto;
    }
}
</style>
</head>

<body>

<header>
    <h1>Smart Dairy</h1>
    <p>Subscription Management</p>
</header>

<div class="container">

    <div class="card">
        <h2>Create New Subscription</h2>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if ("true".equals(success)) {
        %>
            <div class="message success">
                Subscription saved successfully!
            </div>
        <%
            }

            if (error != null) {
        %>
            <div class="message error">
                <%
                    if ("required".equals(error)) {
                        out.print("Please fill all required fields.");
                    } else if ("invalid".equals(error)) {
                        out.print("Invalid customer, product, quantity or date.");
                    } else if ("date".equals(error)) {
                        out.print("End date cannot be earlier than start date.");
                    } else {
                        out.print("Unable to save subscription. Check the server Console and database.");
                    }
                %>
            </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/SubscriptionServlet"
              method="post">

            <div class="form-grid">

                <div>
                    <label for="customer_id">Customer ID *</label>
                    <input type="number" id="customer_id"
                           name="customer_id" min="1" required>
                </div>

                <div>
                    <label for="product_id">Product ID *</label>
                    <input type="number" id="product_id"
                           name="product_id" min="1" required>
                </div>

                <div>
                    <label for="quantity">Quantity (litres) *</label>
                    <input type="number" id="quantity"
                           name="quantity" min="0.1" step="0.1" required>
                </div>

                <div>
                    <label for="shift">Delivery Shift *</label>
                    <select id="shift" name="shift" required>
                        <option value="">Select shift</option>
                        <option value="Morning">Morning</option>
                        <option value="Evening">Evening</option>
                        <option value="Both">Both</option>
                    </select>
                </div>

                <div>
                    <label for="start_date">Start Date *</label>
                    <input type="date" id="start_date"
                           name="start_date" required>
                </div>

                <div>
                    <label for="end_date">End Date</label>
                    <input type="date" id="end_date" name="end_date">
                </div>

                <div>
                    <label for="status">Status *</label>
                    <select id="status" name="status" required>
                        <option value="ACTIVE">Active</option>
                        <option value="PAUSED">Paused</option>
                        <option value="COMPLETED">Completed</option>
                    </select>
                </div>

                <div>
                    <label for="remarks">Remarks</label>
                    <textarea id="remarks" name="remarks"
                              rows="2"
                              placeholder="Optional notes"></textarea>
                </div>

                <div class="full">
                    <button type="submit">Save Subscription</button>
                    <a class="secondary"
                       href="${pageContext.request.contextPath}/DashboardServlet">
                       Back to Dashboard
                    </a>
                </div>

            </div>
        </form>
    </div>

</div>

</body>
</html>
```
