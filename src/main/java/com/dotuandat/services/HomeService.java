package com.dotuandat.services;

import java.util.List;

import com.dotuandat.dtos.response.home.SaleStatistic;
import com.dotuandat.dtos.response.home.TimeSeriesStatistic;
import com.dotuandat.dtos.response.order.OrderResponse;
import com.dotuandat.dtos.response.product.ProductResponse;

public interface HomeService {
    List<SaleStatistic> getSaleStatistics();

    List<TimeSeriesStatistic> getTimeSeriesStatistics(String period);

    List<OrderResponse> getRecentRevenue(String filter);

    List<ProductResponse> getTop5Products(String filter);

    List<ProductResponse> getLowStockProducts(int threshold);

    List<ProductResponse> getExpiringProducts(String filter);
}
