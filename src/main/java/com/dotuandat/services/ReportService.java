package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.response.report.*;

public interface ReportService {
    OrderSummary getOrderSummary();

    List<WeeklyRevenueTrend> getMonthlyRevenueTrend();

    List<RevenueByOrderType> getRevenueByOrderType();

    List<CategoryReport> getCategoryReport();

    List<SupplierReport> getSupplierReport();

    List<UserGrowthRate> getUserGrowth();

    List<ProductReport> getTop5ProductsByRevenue();

    List<ProductReport> getBottom5ProductsByRevenue();

    RevenueByProduct getRevenueByProduct(String productCode);
}
