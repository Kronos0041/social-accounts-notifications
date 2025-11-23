//
//  MockData.swift
//  TransitionDemo
//
//  Created by Alex on 23.11.2025.
//


class MockData {
    static let shared = MockData()
    let accounts: [AccountModel] = [
        AccountModel(iconName: "telegramIcon", title: "Telegram Account 1", subtitle: "Основной аккаунт"),
        AccountModel(iconName: "whatsAppIcon", title: "WhatsApp Account 1", subtitle: "Рабочий аккаунт"),
        AccountModel(iconName: "telegramIcon", title: "Telegram Account 2", subtitle: "Второй аккаунт"),
        AccountModel(iconName: "whatsAppIcon", title: "WhatsApp Account 2", subtitle: "Личный аккаунт")
    ]
}
