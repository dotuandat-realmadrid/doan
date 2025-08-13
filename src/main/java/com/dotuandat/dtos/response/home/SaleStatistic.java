package com.dotuandat.dtos.response.home;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SaleStatistic {
    long totalProductsSold;
    double salesGrowthPercent;
    long totalRevenue;
    double revenueGrowthPercent;
    long totalCustomers;
    double customersGrowthPercent;
    String period;
    String periodLabel;
}
