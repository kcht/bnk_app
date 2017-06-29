class SignupForm extends React.Component {
    constructor(props) {
        super(props)
        this.state = {name: '', password: '', email: '', passwordConfirmation: ''};
        this.signUp = this.signUp.bind(this)
        this.handleNameChange = this.handleNameChange.bind(this)
        this.changePassword = this.changePassword.bind(this)
        this.handleEmailChange = this.handleEmailChange.bind(this)
        this.handlePasswordConfirmationChange = this.handlePasswordConfirmationChange.bind(this)
        this.signupButtonDisabled = this.signupButtonDisabled.bind(this)
    }

    signupButtonDisabled() {
        let {name, email, password, passwordConfirmation} = this.state
        return ( !this.passwordsMatch() || password.length == 0 ||
        name.length == 0 || email.length == 0)

    }

    signUp() {
        let {name, email, password} = this.state

        content = {user: {email: email, name: name, password: password, password_confirmation: password}}
        axios.post('/signup', content)
            .then(function (response) {
                console.log(response);
            })
        setTimeout(function () {

            window.location.href = "/users/last"
        }, 3000); //todo: change. This is so that the LAST user is fetched, to give time to write and read to the db. Should this be read from response?
    }

    handleNameChange(event) {
        this.setState({name: event.target.value})
    }

    handleEmailChange(event) {
        this.setState({email: event.target.value})
    }

    handlePasswordConfirmationChange(event) {
        this.setState({passwordConfirmation: event.target.value})
    }

    changePassword(event) {
        this.setState({password: event.target.value})
    }

    passwordsMatch() {
        let {password, passwordConfirmation} = this.state
        return passwordConfirmation === password
    }

    render() {
        let {name, email, password, passwordConfirmation} = this.state
        let {goodPasswordRules} = this.props
        buttonDisabled = this.signupButtonDisabled()

        return (
            <div>
                <ReactBootstrap.Grid>
                    <ReactBootstrap.Row>
                        <ReactBootstrap.Col md={8}>
                            <SignupInput label="Name" id="nameInput" type="text" value={name}
                                         onChange={this.handleNameChange}/>
                            <SignupInput label="Email" id="emailInput" type="email" value={email}
                                         onChange={this.handleEmailChange}/>
                            <SignupInput label="Password" id="passwordInput" type="password"
                                         value={password} onChange={this.changePassword}/>
                            <SignupInput label="Confirm Password" id="passwordConfirmationInput" type="password"
                                         value={passwordConfirmation} onChange={this.handlePasswordConfirmationChange}/>
                            <ReactBootstrap.Button bsStyle="primary" onClick={this.signUp} disabled={buttonDisabled}>Sign
                                me up </ReactBootstrap.Button>
                        </ReactBootstrap.Col>
                        <ReactBootstrap.Col md={4}>
                            { !this.passwordsMatch() &&
                            <ReactBootstrap.Panel bsStyle="danger">Passwords don't match.</ReactBootstrap.Panel> }
                            { email.length == 0 &&
                            <ReactBootstrap.Panel bsStyle="danger">Email can't be empty.</ReactBootstrap.Panel> }
                            { name.length == 0 &&
                            <ReactBootstrap.Panel bsStyle="danger">Name can't be empty.</ReactBootstrap.Panel> }
                            { password.length < 3 &&
                            <ReactBootstrap.Panel bsStyle="danger">Minimal length of password is
                                3.</ReactBootstrap.Panel> }

                            <StrengthMeter rules={goodPasswordRules} password={password}/>
                        </ReactBootstrap.Col>
                    </ReactBootstrap.Row>
                </ReactBootstrap.Grid>
            </div>
        )
    }
}

const ALPHANUMERIC_REGEX = /[0-9]/
const LOWERCASE_REGEX = /[a-z]/
const UPPERCASE_REGEX = /[A-Z]/

SignupForm.defaultProps = {
    goodPasswordRules: [
        {
            label: 'has 6+ characters',
            predicate: password => password.length >= 6
        },
        {
            label: 'contains at least one alphanumeric character (0-9)',
            predicate: password => password.match(ALPHANUMERIC_REGEX) !== null
        },
        {
            label: 'contains at least one lower- and one upper-case letter',
            predicate: password => (password.match(LOWERCASE_REGEX)
            !== null && password.match(UPPERCASE_REGEX) !== null)
        }
    ]
}