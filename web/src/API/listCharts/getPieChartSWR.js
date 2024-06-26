// Importing the useSWR hook from the "swr" library
import useSWR from "swr";
import { apiIP } from "../../config";

// data fetching을 위한 함수(fetcher)
const fetcher = (...args) =>
  fetch(...args).then((res) => {
    switch (res.status) {
      //response status가 200 (OK)인 경우, JSON을 파싱한 후 data 반환
      case 200:
        return res.json();
      //response status가 404 (Not Found)인 경우, 에러 throw
      case 404:
        throw new Error("No Pie Data Found");
      //그 외 response status의 경우, JSON을 파싱한 후 data 반환
      default:
        return res.json();
    }
  }
);


//custom Hook인 usePieChartFetch를 export 
export const usePieChartFetch = (startDate, endDate) => {
    //pie chart 데이터를 API 서버로 부터 fetch
    const { data, error } = useSWR(
      //query parameter : startDate, endDate
      `http://${apiIP}/meat/statistic?type=0&start=${startDate}&end=${endDate}`, 
      fetcher
    );

    //fetched data, loading state, error를 포함한 object 반환 
    return {
      data,
      isLoading: !error && !data,
      error,
    };
  };