<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String ctx = request.getContextPath();
    String userName = String.valueOf(session.getAttribute("userName"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Dairy | Choose Module</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:Arial,sans-serif; }
body { background:#f3f7f3; color:#26332a; min-height:100vh; }
.top { background:#1b5e20; color:#fff; padding:18px 28px; display:flex; justify-content:space-between; align-items:center; }
.top a { color:#fff; text-decoration:none; font-size:14px; }
.wrap { max-width:900px; margin:50px auto; padding:0 20px; text-align:center; }
h1 { color:#1b5e20; margin-bottom:8px; }
.sub { color:#68736a; margin-bottom:34px; }
.grid { display:grid; grid-template-columns:1fr 1fr; gap:22px; }
.card { background:#fff; border-radius:14px; padding:34px 26px; text-decoration:none; color:inherit;
        box-shadow:0 4px 16px #0000000f; border-top:6px solid #43a047; transition:transform .2s; }
.card:hover { transform:translateY(-4px); }
.card.biz { border-top-color:#1565c0; }
.emoji { font-size:48px; margin-bottom:14px; }
.card h2 { margin-bottom:10px; font-size:21px; }
.card p { font-size:13px; color:#68736a; line-height:1.6; }
.tag { display:inline-block; margin-top:14px; font-size:12px; font-weight:bold; color:#2e7d32; }
.card.biz .tag { color:#1565c0; }
@media (max-width:640px) { .grid { grid-template-columns:1fr; } }
</style>
</head>
<body>
<div class="top">
    <strong>🥛 Smart Dairy</strong>
    <span>👤 <%= userName %> &nbsp;|&nbsp; <a href="<%= ctx %>/LogoutServlet">Logout</a></span>
</div>
<div class="wrap">
    <h1>Module chuniye</h1>
    <p class="sub">Aapko kis kaam ke liye software chalana hai?</p>
    <div class="grid">
        <a class="card" href="<%= ctx %>/milk/milk_home.jsp">
            <div class="emoji">🥛</div>
            <h2>Milk Module</h2>
            <p>Sirf doodh ke liye. Kisan aur grahak, doodh sangrah (subah/shaam, gaay/bhains),
               rate chart, advance, bhugtan aur doodh bikri.</p>
            <span class="tag">Open Milk Module →</span>
        </a>
        <a class="card biz" href="<%= ctx %>/dashboard.jsp">
            <div class="emoji">🏪</div>
            <h2>Business Module</h2>
            <p>Har type ke products ke liye. Products, inventory, orders, distributors,
               delivery, invoice, subscription aur expenses.</p>
            <span class="tag">Open Business Module →</span>
        </a>
    </div>
</div>
</body>
</html>
