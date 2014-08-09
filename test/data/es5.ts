class Person {

    private _name:string = null;

    constructor() {

    }

    public get name():string
    {
        return "The person name is " + this._name;
    }

    public set name(value:string)
    {
        this._name = value;
    }

}