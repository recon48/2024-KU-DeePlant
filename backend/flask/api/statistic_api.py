from flask import (
    Blueprint,
    jsonify,
    request,
    current_app,
)
from db.db_model import (
    Meat,
)
from db.db_controller import (
    get_num_of_processed_raw,
    get_num_of_cattle_pig,
    get_num_of_primal_part,
    get_num_by_farmAddr,
    get_probexpt_of_rawmeat,
    get_probexpt_of_processedmeat,
    get_sensory_of_rawmeat,
    get_sensory_of_processedmeat,
    get_sensory_of_processed_heatedmeat,
    get_sensory_of_raw_heatedmeat,
    get_probexpt_of_processed_heatedmeat,
)
from utils import *

statistic_api = Blueprint("statistic_api", __name__)


# 1. 신선육, 숙성육 비율(소, 돼지 전체)
@statistic_api.route("/ratio/fresh-and-processed", methods=["GET", "POST"])
def getRatioFreshAndProcessed():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_num_of_processed_raw(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 2. 소, 돼지 개수
@statistic_api.route("/counts/cattle-and-pork", methods=["GET", "POST"])
def getCountsCattleAndPork():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_num_of_cattle_pig(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 3. 대분류 부위 별 개수(소, 돼지)
@statistic_api.route("/counts/by-large-part", methods=["GET", "POST"])
def getCountsByLargePart():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_num_of_primal_part(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 4. 농장 지역 별 개수(소,돼지)
@statistic_api.route("/counts/by-farm-location", methods=["GET", "POST"])
def getCountsByFarmLocation():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_num_by_farmAddr(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 5. 신선육 맛데이터 항목 별 평균, 최대, 최소
@statistic_api.route("/probexpt-stats/fresh", methods=["GET", "POST"])
def getProbexptStatsOfFresh():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_probexpt_of_rawmeat(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 6. 처리육 맛데이터 항목 별 평균, 최대, 최소
@statistic_api.route("/probexpt-stats/processed", methods=["GET", "POST"])
def getProbexptStatsOfProcessed():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            seqno = safe_int(request.args.get("seqno"))
            if start and end and seqno:
                return get_probexpt_of_processedmeat(db_session, seqno, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )

# 7. 신선육 관능검사 데이터 항목 별 평균, 최대, 최소
@statistic_api.route("/sensory-stats/fresh", methods=["GET", "POST"])
def getSensoryStatsOfFresh():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_sensory_of_rawmeat(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )

# 8. 가공육 관능검사 데이터 항목 별 평균, 최대, 최소
@statistic_api.route("/sensory-stats/processed", methods=["GET", "POST"])
def getSensoryStatsOfProcessed():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            seqno = safe_int(request.args.get("seqno"))
            if start and end:
                return get_sensory_of_processedmeat(db_session, seqno, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 9. 가열된 신선육 관능 데이터 각 항목 별 평균, 최대, 최소
@statistic_api.route("/sensory-stats/heated-fresh", methods=["GET", "POST"])
def getSensoryStatsOfHeatedFresh():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_sensory_of_raw_heatedmeat(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 10. 가열된 가공육 관능 데이터 각 항목 별 평균, 최대, 최소
@statistic_api.route("/sensory-stats/heated-processed", methods=["GET", "POST"])
def getSensoryStatsOfHeatedProcessed():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            seqno = safe_int(request.args.get("seqno"))
            if start and end:
                return get_sensory_of_processed_heatedmeat(
                    db_session, seqno, start, end
                )
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )


# 11. 가열된 가공육 맛 데이터 각 항목 별 평균, 최대, 최소
@statistic_api.route("/probexpt-stats/heated-processed", methods=["GET", "POST"])
def getProbexptStatsOfHeatedProcessed():
    try:
        if request.method == "GET":
            db_session = current_app.db_session
            start = safe_str(request.args.get("start"))
            end = safe_str(request.args.get("end"))
            if start and end:
                return get_probexpt_of_processed_heatedmeat(db_session, start, end)
            else:
                return jsonify("No id parameter"), 401

        else:
            return jsonify({"msg": "Invalid Route, Please Try Again."}), 404
    except Exception as e:
        logger.exception(str(e))
        return (
            jsonify(
                {"msg": "Server Error", "time": datetime.now().strftime("%H:%M:%S")}
            ),
            505,
        )
