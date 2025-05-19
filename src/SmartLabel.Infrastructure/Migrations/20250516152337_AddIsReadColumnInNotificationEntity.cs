﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartLabel.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddIsReadColumnInNotificationEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsRead",
                table: "UserNotifications",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsRead",
                table: "UserNotifications");
        }
    }
}
