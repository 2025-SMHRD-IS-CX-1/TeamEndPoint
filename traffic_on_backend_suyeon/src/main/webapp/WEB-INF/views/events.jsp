<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TRAFFIC:ON - 이벤트 및 소식</title>
        <link rel="stylesheet" href="/css/EventPage.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="event-page-container">
            <header class="page-header">
                <button class="back-btn" onclick="history.back()">
                    <i data-lucide="chevron-left"></i>
                </button>
                <h2>이벤트 및 소식</h2>
                <div class="header-spacer"></div>
            </header>

            <div class="event-list-section">
                <div class="event-card">
                    <div class="event-tag badge-fest">축제</div>
                    <div class="event-content">
                        <h3>광주 세계 김치 축제</h3>
                        <p class="event-date">2024.10.18 ~ 10.20</p>
                    </div>
                    <i data-lucide="chevron-right"></i>
                </div>

                <div class="event-card">
                    <div class="event-tag badge-info">공지</div>
                    <div class="event-content">
                        <h3>지하철 공사로 인한 우회 안내</h3>
                        <p class="event-date">2024.11.01 ~ 11.15</p>
                    </div>
                    <i data-lucide="chevron-right"></i>
                </div>
            </div>
        </div>
        <script>lucide.createIcons();</script>
    </body>

    </html>