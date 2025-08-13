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
public class TimeSeriesStatistic {
    String timestamp; // Mốc thời gian định dạng ISO 8601
    long totalProductsSold;
    double totalRevenue;
    long totalCustomers;
}
