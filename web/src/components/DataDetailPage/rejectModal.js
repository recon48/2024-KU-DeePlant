import { useState } from "react"
import {Backdrop,Box, Modal, Fade,Button, Typography} from '@mui/material';
import {FaRegTimesCircle} from "react-icons/fa";
import StateChangedModal from "./stateChangedModal";
import updateDataStatus from "../../API/updateDataStatus";

const navy =  '#0F3659';

// 반려 여부 확인 모달
export default function RejectModal({id, setConfirmVal, confirmVal}) {
    //화면 창 닫기
    const [open, setOpen] = useState(true);
    const handleClose = () => {setOpen(false); setConfirmVal(null)};

    // 반려 Api 호출
    const changeConfirmState=()=>{
        updateDataStatus(confirmVal, id, setStateChanged);
    };

    
    // 최종 변경 완료 팝업
    const [stateChanged, setStateChanged] = useState(false);

    return (
      <div>
        <Modal
          aria-labelledby="transition-modal-title"
          aria-describedby="transition-modal-description"
          open={open}
          onClose={handleClose}
          closeAfterTransition
          slots={{ backdrop: Backdrop }}
          slotProps={{
            backdrop: {
              timeout: 500,
            },
          }}
        >
          <Fade in={open}>
            <Box sx={style}>
              <Typography id="transition-modal-title" variant="h6" component="h2">
                <span style={{color:navy, fontSize:'20px', fontWeight:'600'}}>
                    반려하시겠습니까?
                </span>
                <div></div>
                <span style={{color: '#b0bec5', fontSize:'12px', lineHeight:'5px'}}>
                    관리번호 '{id}'의 일반 데이터를 
                </span>
                <span style={{color: '#b0bec5', fontSize:'12px', lineHeight:'5px', textDecoration:'underline'}}>
                    반려
                </span>
                <span style={{color: '#b0bec5', fontSize:'12px', lineHeight:'5px'}}>
                    합니다.
                </span>
              </Typography>
              
              <div style={{display:'flex', width:'100%', justifyContent:'end'}}>
                <Button variant="outlined" sx={{marginRight:'5px'}} onClick={handleClose }  style={{backgroundColor:'white',marginRight:'10px',border:`1px solid ${navy}`, height:'35px', borderRadius:'10px', width:'100px', fontSize:'17px'}}>
                  취소
                </Button>
                <Button variant="contained" onClick={changeConfirmState} style={{backgroundColor:'#e53935',color:'white', height:'35px', borderRadius:'10px', width:'100px', fontSize:'17px',}}>
                    <FaRegTimesCircle/>
                    반려
                </Button>
              </div>
              {
                stateChanged
                && <StateChangedModal confirmVal={confirmVal} setStateChanged={setStateChanged} handleParentClose={handleClose}/>
              }
            </Box>
          </Fade>
        </Modal>
      </div>
    );
  }


const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 500,
    bgcolor: 'background.paper',
    boxShadow: 24,
    p: 4,
    borderRadius:'10px'
  };