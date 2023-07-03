window.addEventListener('DOMContentLoaded',(event)=>{getVisitcount();})
const functionApi ="https://resumecounterazure.azurewebsites.net/api/GetresumeCounter?code=7Esq0IaYSll_a_raBAsztfB868gwWAmlgBxqeEVhTMsdAzFuNF_F0Q==";

const getVisitcount =()=>{
    let count =0;
    fetch(functionApi).then(response=>{
        return response.json()
    }).then(response=>{
        console.log("The site called the function api")
        count = response.value;
        document.getElementById("counter").innerText =count;
    }).catch(function(error){
        console.log(error);
    });
    return count;

}