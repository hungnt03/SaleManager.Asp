using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace SaleManager.Migrations
{
    public partial class _20220113 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Transaction_Customer_CustomerId",
                table: "Transaction");

            migrationBuilder.DropForeignKey(
                name: "FK_Transaction_Supplier_SupplierId",
                table: "Transaction");

            migrationBuilder.DropIndex(
                name: "IX_Transaction_CustomerId",
                table: "Transaction");

            migrationBuilder.DropIndex(
                name: "IX_Transaction_SupplierId",
                table: "Transaction");

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 984, DateTimeKind.Local).AddTicks(3277));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 985, DateTimeKind.Local).AddTicks(7148));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 3,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 985, DateTimeKind.Local).AddTicks(7192));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 4,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 985, DateTimeKind.Local).AddTicks(7194));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 5,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 985, DateTimeKind.Local).AddTicks(7196));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 986, DateTimeKind.Local).AddTicks(9848));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 987, DateTimeKind.Local).AddTicks(1753));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 3,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 987, DateTimeKind.Local).AddTicks(1826));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 4,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 987, DateTimeKind.Local).AddTicks(1828));

            migrationBuilder.UpdateData(
                table: "Supplier",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 13, 16, 40, 23, 986, DateTimeKind.Local).AddTicks(7676));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 672, DateTimeKind.Local).AddTicks(3161));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 673, DateTimeKind.Local).AddTicks(6795));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 3,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 673, DateTimeKind.Local).AddTicks(6830));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 4,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 673, DateTimeKind.Local).AddTicks(6833));

            migrationBuilder.UpdateData(
                table: "Category",
                keyColumn: "Id",
                keyValue: 5,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 673, DateTimeKind.Local).AddTicks(6834));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 674, DateTimeKind.Local).AddTicks(8921));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 675, DateTimeKind.Local).AddTicks(1027));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 3,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 675, DateTimeKind.Local).AddTicks(1106));

            migrationBuilder.UpdateData(
                table: "Product",
                keyColumn: "Id",
                keyValue: 4,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 675, DateTimeKind.Local).AddTicks(1109));

            migrationBuilder.UpdateData(
                table: "Supplier",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2022, 1, 6, 14, 29, 20, 674, DateTimeKind.Local).AddTicks(6941));

            migrationBuilder.CreateIndex(
                name: "IX_Transaction_CustomerId",
                table: "Transaction",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Transaction_SupplierId",
                table: "Transaction",
                column: "SupplierId");

            migrationBuilder.AddForeignKey(
                name: "FK_Transaction_Customer_CustomerId",
                table: "Transaction",
                column: "CustomerId",
                principalTable: "Customer",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Transaction_Supplier_SupplierId",
                table: "Transaction",
                column: "SupplierId",
                principalTable: "Supplier",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
