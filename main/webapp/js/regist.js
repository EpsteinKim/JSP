function sendit() {
	const form = document.regform;
	const userid = form.userid;
	const userpw = form.userpw;
	const userpw_re = form.userpw_re;
	const name = form.name;
	const hp = form.hp;
	const email = form.email;
	const hobby = form.hobby;
	const isssn = form.isssn;
	const isidcheck = form.isidcheck;
	// const hobby = document.getElementsByName('hobby');

	// 정규식
	const expNameText = /[가-힣]+$/;
	const expHpText = /^\d{3}-\d{3,4}-\d{4}$/;
	const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\.\-]+\.[A-Za-z0-9]+$/; // 무조건 붙여써야됨

	if (userid.value == "") {
		alert("아이디를 입력하세요");
		userid.focus(); //focus 커서
		return false;
	}

	if (userid.value.length < 4 || userid.value.length > 20) {
		alert("아이디는 4자이상 20자 이하로 입력하세요");
		userid.focus();
		return false;
	}
	if (isidcheck.value == 'n') {
		alert('아이디 중복체크를 확인하세요');
		userid.focus();
		return false;
	}
	if (userpw.value == "") {
		alert("비밀번호를 입력하세요");
		userpw.focus(); //focus 커서
		return false;
	}
	if (userpw.value.length < 4 || userpw.value.length > 20) {
		alert("비밀번호는 4자이상 20자 이하로 입력하세요");
		userpw.focus();
		return false;
	}

	if (userpw.value != userpw_re.value) {
		alert("비밀번호와 비밀번호 확인의 값이 다릅니다");
		userpw.focus();
		return false;
	}

	if (!expNameText.test(name.value)) {
		alert("이름 형식을 확인하세요\n한글만 입력 가능합니다.");
		name.focus();
		return false;
	}
	if (!expHpText.test(hp.value)) {
		alert("휴대폰번호 형식을 확인하세요\n하이픈(-)을 포함해야 합니다");
		hp.focus();
		return false;
	}
	if (!expEmailText.test(email.value)) {
		alert("이메일 형식을 확인하세요");
		email.focus();
		return false;
	}

	let count = 0;

	for (let i in hobby) if (hobby[i].checked) count++;

	if (count == 0) {
		alert("취미는 적어도 1개이상 선택하세요");
		return false;
	}

	if (isssn.value == "n") {
		alert("주민등록번호 검증버튼을 눌러주세요");
	}

	return true;
}





function moveFocus() {
	const ssn1 = document.getElementById("ssn1");
	if (ssn1.value.length >= 6) {
		document.getElementById("ssn2").focus();
	}
}
function ssnCheck() {
	const ssn1 = document.getElementById("ssn1");
	const ssn2 = document.getElementById("ssn2");
	const isssn = document.getElementById("isssn");
	if (ssn1.value == "" || ssn2.value == "") {
		alert("주민등록번호를 입력하세요");
		return false;
	}

	const ssn = ssn1.value.concat(ssn2.value); // 문자열

	const s1 = Number(ssn.substr(0, 1)) * 2;
	const s2 = Number(ssn.substr(1, 1)) * 3;
	const s3 = Number(ssn.substr(2, 1)) * 4;
	const s4 = Number(ssn.substr(3, 1)) * 5;
	const s5 = Number(ssn.substr(4, 1)) * 6;
	const s6 = Number(ssn.substr(5, 1)) * 7;
	const s7 = Number(ssn.substr(6, 1)) * 8;
	const s8 = Number(ssn.substr(7, 1)) * 9;
	const s9 = Number(ssn.substr(8, 1)) * 2;
	const s10 = Number(ssn.substr(9, 1)) * 3;
	const s11 = Number(ssn.substr(10, 1)) * 4;
	const s12 = Number(ssn.substr(11, 1)) * 5;
	const s13 = Number(ssn.substr(12, 1));

	let result = s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9 + s10 + s11 + s12;
	result %= 11;
	result = 11 - result;
	if (result >= 10) result %= 10;

	if (result == s13) {
		alert("유효한 주민등록번호입니다.");
		isssn.value = 'y';
	} else {
		alert("유효하지 않은 주민등록번호입니다.");
	}
}

function ssnChange() {
	const isssn = document.getElementById('isssn');
	isssn.value = 'n';
}

window.onload = function() {
	document.getElementById('btnIdCheck').addEventListener('click', function() {
		const id = document.regform.userid.value;
		if (id == "") {
			document.getElementById('idCheckMsg').innerHTML = "아이디를 입력해주세요";
			document.getElementById('userid').focus();
			return;
		}
		const xhr = new XMLHttpRequest();
		xhr.open('GET', "idcheck.jsp?userid=" + id, true);
		xhr.send();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				document.getElementById('idCheckMsg').innerHTML = xhr.responseText;
				if (document.getElementById('idCheckMsg').innerText == '생성 가능한 아이디입니다.') {
					document.getElementById('isidcheck').value = 'y';
				}
			}
		}
	});


	document.getElementById('userid').addEventListener('keyup', function() {
			document.getElementById('isidcheck').value = 'n';
	});
	
}










