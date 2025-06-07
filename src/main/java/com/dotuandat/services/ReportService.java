package com.dotuandat.services;

import com.dotuandat.dtos.response.report.*;

import java.util.List;

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
