var pwErrors = true;
var addrErrors = true;
function passwordCheck(val){
    let submitBtn = document.getElementById("submit-btn");
    if(val.length < 8){
        pwErrors = "Password must be atleast 8 characters";
        submitBtn.classList.remove("active");
    }
    else if(!val.match(/[a-z]/i)){
        pwErrors = "password must have atleast one alphabetic character";
        submitBtn.classList.remove("active");
    }
    else if(!val.match(/[0-9]/)){
        pwErrors = "password must have atleast one number";
        submitBtn.classList.remove("active");
    }
    else if(!val.includes("%")){
        pwErrors = "password must contain '%' symbol";
        submitBtn.classList.remove("active");
    } else {
        pwErrors = "";
        if(!(pwErrors)){
            submitBtn.classList.add("active");
        }
    }
}

function errorsDisplay(){
    var pwErr = document.getElementById("passwordErrors")
    pwErr.innerHTML = pwErrors;
}