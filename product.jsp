
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
    import="com.smartdairy.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Dairy - Products</title>

<style>
* { box-sizing: border-box; }

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f2f8f5;
    color: #263b32;
}

header {
    background: #287d61;
    color: white;
    padding: 20px 30px;
}

header h1 { margin: 0; font-size: 25px; }

nav {
    background: #ffffff;
    padding: 14px 30px;
    border-bottom: 1px solid #dce9e2;
}

nav a {
    color: #287d61;
    text-decoration: none;
    font-weight: bold;
    margin-right: 22px;
}

.container {
    max-width: 1100px;
    margin: 28px auto;
    padding: 0 18px;
}

.card {
    background: white;
    padding: 24px;
    border-radius: 12px;
    margin-bottom: 24px;
    box-shadow: 0 3px 12px #0000000b;
}

h2 {
    margin-top: 0;
    color: #287d61;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 16px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}

input, select {
    width: 100%;
    padding: 11px;
    border: 1px solid #cbdad1;
    border-radius: 7px;
    background: white;
}

button {
    margin-top: 18px;
    background: #287d61;
    color: white;
    border: 0;
    padding: 12px 23px;
    border-radius: 7px;
    cursor: pointer;
}

button:hover { background: #1e624c; }

.message {
    padding: 12px;
    margin-bottom: 16px;
    border-radius: 7px;
    background: #e3f5e9;
    color: #17653d;
}

.error {
    background: #ffeded;
    color: #a12626;
}

.table-wrap { overflow-x: auto; }

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 700px;
}

th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #e1ebe5;
}

th {
    background: #e8f4ed;
    color: #245c47;
}

@media (max-width: 600px) {
    .form-grid { grid-template-columns: 1fr; }
    header { padding: 18px; }
}
</style>
</head>

<body>

<header>
    <h1>Smart Dairy</h1>
    <p>Product & Inventory Management</p>
</header>

<nav>
    <a href="${pageContext.request.contextPath}/DashboardServlet">Dashboard</a>
    <a href="${pageContext.request.contextPath}/ProductServlet">Products</a>
    <a href="${pageContext.request.contextPath}/InventoryServlet">Inventory</a>
</nav>

<div class="container">

    <% if ("true".equals(request.getParameter("success"))) { %>
        <div class="message">Product saved successfully!</div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <div class="message error">
            Product could not be saved. Please check the details and database.
        </div>
    <% } %>

    <section class="card">
        <h2>Add New Product</h2>

        <form action="${pageContext.request.contextPath}/ProductServlet"
              method="post">

            <div class="form-grid">

                <div>
                    <label for="product_name">Product Name *</label>
                    <input type="text" id="product_name"
                           name="product_name" required>
                </div>

                <div>
                    <label for="category">Category</label>
                    <select id="category" name="category">
                        <option value="Milk">Milk</option>
                        <option value="Milk Product">Milk Product</option>
                        <option value="Dairy">Dairy</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div>
                    <label for="unit">Unit</label>
                    <select id="unit" name="unit">
                        <option value="Litre">Litre</option>
                        <option value="Kg">Kg</option>
                        <option value="Packet">Packet</option>
                        <option value="Piece">Piece</option>
                    </select>
                </div>

                <div>
                    <label for="purchase_price">Purchase Price</label>
                    <input type="number" id="purchase_price"
                           name="purchase_price" min="0"
                           step="0.01" value="0">
                </div>

                <div>
                    <label for="selling_price">Selling Price *</label>
                    <input type="number" id="selling_price"
                           name="selling_price" min="0"
                           step="0.01" required>
                </div>

                <div>
                    <label for="stock">Current Stock</label>
                    <input type="number" id="stock" name="stock"
                           min="0" step="0.01" value="0">
                </div>

                <div>
                    <label for="minimum_stock">Minimum Stock</label>
                    <input type="number" id="minimum_stock"
                           name="minimum_stock" min="0"
                           step="0.01" value="0">
                </div>

                <div>
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="ACTIVE">Active</option>
                        <option value="INACTIVE">Inactive</option>
                    </select>
                </div>

            </div>

            <button type="submit">Save Product</button>
        </form>
    </section>

    <section class="card">
        <h2>Product Records</h2>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Unit</th>
                        <th>Purchase Price</th>
                        <th>Selling Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    String sql = "SELECT id, product_name, category, unit, "
                               + "purchase_price, selling_price, stock, status "
                               + "FROM products ORDER BY id DESC";

                    try (Connection con = DBConnection.getConnection();
                         PreparedStatement ps = con.prepareStatement(sql);
                         ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("product_name") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getString("unit") %></td>
                        <td><%= rs.getBigDecimal("purchase_price") %></td>
                        <td><%= rs.getBigDecimal("selling_price") %></td>
                        <td><%= rs.getBigDecimal("stock") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="8">
                            Unable to load products. Check the database
                            connection and products table.
                        </td>
                    </tr>
                <%
                        }
                %>
                </tbody>
            </table>
        </div>
    </section>

</div>
</body>
</html>

