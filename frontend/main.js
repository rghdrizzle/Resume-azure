window.addEventListener('DOMContentLoaded',(event)=>{getVisitcount();})
const functionApi ='';

const getVisitcount =()=>{
    let count =1;
    fetch(functionApi).then(response=>{
        return response.json
    }).then(response=>{
        console.log("The site called the function api")
        count = response.count;
        document.getElementById("counter").innerText =count;
    }).catch(function(error){
        console.log(error);
    });
    return count;

}