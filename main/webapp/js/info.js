function sendit() {
	const form = document.regform;
	const userpw = form.userpw;
	const userpw_re = form.userpw_re;
	const name = form.name;
	const hp = form.hp;
	const email = form.email;
	const hobby = form.hobby;
	// const hobby = document.getElementsByName('hobby');

	// 정규식
	const expNameText = /[가-힣]+$/;
	const expHpText = /^\d{3}-\d{3,4}-\d{4}$/;
	const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\.\-]+\.[A-Za-z0-9]+$/; // 무조건 붙여써야됨

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


	return true;
}









