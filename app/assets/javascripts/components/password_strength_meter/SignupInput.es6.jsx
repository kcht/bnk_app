class SignupInput extends React.Component {
    render(){
        let {id, type, value, onChange,label } = this.props
        return (
            <div>
                <label for={id} className="control-label">{label}</label>
                <ReactBootstrap.FormControl id ={id}  type={type}
                                            value={value} onChange={onChange} />
            </div>
        )
    }
}