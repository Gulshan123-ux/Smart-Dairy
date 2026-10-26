
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);

    if (userSession == null ||
        userSession.getAttribute("userId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String userName = String.valueOf(
        userSession.getAttribute("userName")
    );

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Dairy | Dashboard</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f3f7f3;
    color: #26332a;
}

.layout {
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 245px;
    background: #1b5e20;
    color: white;
    padding: 24px 14px;
    flex-shrink: 0;
}

.brand {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 8px;
}

.tagline {
    text-align: center;
    font-size: 12px;
    color: #dcedc8;
    margin-bottom: 28px;
}

.nav-title {
    font-size: 11px;
    color: #c8e6c9;
    padding: 12px 12px 7px;
    text-transform: uppercase;
}

.sidebar a {
    display: block;
    color: white;
    text-decoration: none;
    padding: 12px;
    margin: 4px 0;
    border-radius: 7px;
    font-size: 14px;
}

.sidebar a:hover,
.sidebar a.active {
    background: #2e7d32;
}

.main {
    flex: 1;
    min-width: 0;
}

.topbar {
    background: white;
    padding: 20px 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    box-shadow: 0 2px 8px #0000000c;
}

.topbar h1 {
    font-size: 23px;
}

.user-info {
    font-size: 14px;
    color: #336638;
}

.content {
    padding: 28px;
}

.welcome {
    background: linear-gradient(120deg, #2e7d32, #66bb6a);
    color: white;
    padding: 26px;
    border-radius: 13px;
    margin-bottom: 25px;
}

.welcome h2 {
    margin-bottom: 8px;
    font-size: 25px;
}

.welcome p {
    font-size: 14px;
    line-height: 1.6;
}

.section-title {
    margin: 24px 0 15px;
    font-size: 19px;
}

.cards {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 18px;
}

.card {
    background: white;
    padding: 22px;
    border-radius: 12px;
    border-left: 5px solid #43a047;
    box-shadow: 0 3px 12px #0000000a;
    transition: transform 0.2s;
}

.card:hover {
    transform: translateY(-3px);
}

.card .emoji {
    font-size: 27px;
    margin-bottom: 12px;
}

.card h3 {
    font-size: 16px;
    margin-bottom: 8px;
}

.card p {
    font-size: 13px;
    color: #68736a;
    line-height: 1.5;
}

.card a {
    display: inline-block;
    margin-top: 14px;
    text-decoration: none;
    color: #2e7d32;
    font-weight: bold;
    font-size: 13px;
}

.quick-links {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 18px;
}

.quick-links a {
    padding: 12px 16px;
    border-radius: 7px;
    background: white;
    border: 1px solid #d8e7d8;
    text-decoration: none;
    color: #2e7d32;
    font-size: 13px;
    font-weight: bold;
}

.quick-links a:hover {
    background: #e8f5e9;
}

.footer {
    text-align: center;
    padding: 20px;
    font-size: 12px;
    color: #788078;
}

@media (max-width: 900px) {
    .cards {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .sidebar {
        width: 205px;
    }
}

@media (max-width: 600px) {
    .layout {
        display: block;
    }

    .sidebar {
        width: 100%;
    }

    .sidebar a {
        display: inline-block;
        margin: 3px;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .content {
        padding: 16px;
    }

    .topbar {
        padding: 16px;
        flex-wrap: wrap;
    }
}
</style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="brand">🥛 Smart Dairy</div>
        <div class="tagline">Dairy Management System</div>

        <div class="nav-title">Main Menu</div>
        <a class="active" href="<%= context %>/dashboard.jsp">
            🏠 Dashboard
        </a>
        <a href="<%= context %>/milk_collection.jsp">
            🥛 Milk Collection
        </a>
        <a href="<%= context %>/supplier.jsp">
            👨‍🌾 Suppliers
        </a>
        <a href="<%= context %>/customer.jsp">
            👥 Customers
        </a>
        <a href="<%= context %>/product.jsp">
            🧃 Products
        </a>

        <div class="nav-title">Operations</div>
        <a href="<%= context %>/inventory.jsp">
            📦 Inventory
        </a>
        <a href="<%= context %>/order.jsp">
            🛒 Orders
        </a>
        <a href="<%= context %>/distributor.jsp">
            🚚 Distributors
        </a>
        <a href="<%= context %>/delivery.jsp">
            🚛 Deliveries
        </a>

        <div class="nav-title">Finance</div>
        <a href="<%= context %>/payments.jsp">
            💳 Payments
        </a>
        <a href="<%= context %>/subscription.jsp">
            🔄 Subscriptions
        </a>
        <a href="<%= context %>/invoice.jsp">
            🧾 Invoices
        </a>
        <a href="<%= context %>/expense.jsp">
            💰 Expenses
        </a>

        <div class="nav-title">Account</div>
        <a href="<%= context %>/modules.jsp">
            🔀 Switch Module
        </a>
        <a href="<%= context %>/LogoutServlet">
            ↩ Logout
        </a>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">

        <header class="topbar">
            <h1>Dashboard</h1>
            <div class="user-info">
                👤 Welcome, <strong><%= userName %></strong>
            </div>
        </header>

        <section class="content">

            <div class="welcome">
                <h2>Welcome to Smart Dairy! 🥛</h2>
                <p>
                    Manage your dairy operations in one place.
                    Access milk collection, customers, products,
                    subscriptions, deliveries and financial records
                    from this dashboard.
                </p>
            </div>

            <h2 class="section-title">Dairy Management Modules</h2>

            <div class="cards">

                <div class="card">
                    <div class="emoji">🥛</div>
                    <h3>Milk Collection</h3>
                    <p>Record daily milk quantity, shift, fat and SNF.</p>
                    <a href="<%= context %>/milk_collection.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">👥</div>
                    <h3>Customer Management</h3>
                    <p>Manage customer information and records.</p>
                    <a href="<%= context %>/customer.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🧃</div>
                    <h3>Product Management</h3>
                    <p>Maintain dairy products, rates and details.</p>
                    <a href="<%= context %>/product.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">📦</div>
                    <h3>Inventory</h3>
                    <p>Track stock and inventory information.</p>
                    <a href="<%= context %>/inventory.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🛒</div>
                    <h3>Orders</h3>
                    <p>Manage orders and their processing status.</p>
                    <a href="<%= context %>/order.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🔄</div>
                    <h3>Subscriptions</h3>
                    <p>Create and manage recurring dairy subscriptions.</p>
                    <a href="<%= context %>/subscription.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">💳</div>
                    <h3>Payments</h3>
                    <p>Record and manage payment transactions.</p>
                    <a href="<%= context %>/payments.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🧾</div>
                    <h3>Invoices</h3>
                    <p>Access invoice records and billing information.</p>
                    <a href="<%= context %>/invoice.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">💰</div>
                    <h3>Expenses</h3>
                    <p>Maintain dairy business expense records.</p>
                    <a href="<%= context %>/expense.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">👨‍🌾</div>
                    <h3>Suppliers</h3>
                    <p>Manage milk suppliers and their details.</p>
                    <a href="<%= context %>/supplier.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🚚</div>
                    <h3>Distributors</h3>
                    <p>Maintain distributor information.</p>
                    <a href="<%= context %>/distributor.jsp">
                        Open Module →
                    </a>
                </div>

                <div class="card">
                    <div class="emoji">🚛</div>
                    <h3>Delivery Management</h3>
                    <p>Manage dairy product delivery records.</p>
                    <a href="<%= context %>/delivery.jsp">
                        Open Module →
                    </a>
                </div>

            </div>

            <h2 class="section-title">Quick Access</h2>

            <div class="quick-links">
                <a href="<%= context %>/MilkCollectionServlet">
                    + Milk Collection
                </a>
                <a href="<%= context %>/CustomerServlet">
                    + Customer
                </a>
                <a href="<%= context %>/ProductServlet">
                    + Product
                </a>
                <a href="<%= context %>/SubscriptionServlet">
                    + Subscription
                </a>
                <a href="<%= context %>/InvoiceServlet">
                    + Invoice
                </a>
            </div>

        </section>

        <footer class="footer">
            © 2026 Smart Dairy Management System | All Rights Reserved
        </footer>

    </main>
</div>

</body>
</html>
