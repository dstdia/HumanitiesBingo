public class BingoController {
    
    private List<CardMember__c> cardMembers;
    public string proposedWord {public get; public set;}
    public List<Integer> randomLog {public get; private set;}
    public List<String> bingoItems {  public get; private set;}
    
    public BingoController() {
        randomLog = new List<Integer>();
    }
    
    private Integer randomItem(Integer arraySize) {
        
        return Integer.valueOf(Math.floor(Math.random() * arraySize));
    }
    
    public List<Word__c> getWordRecords() {
        
        List<Word__c> words = [SELECT Id, Name FROM Word__c];
        List<Word__c> cardSelection = new List<Word__c>(); 
            
        for (Integer i = 1; i <= 25; i++) {
            
            Integer iRandom = randomItem(words.size());
            
            System.debug('Random Number is: ' + iRandom);
            this.randomLog.add(iRandom);
            
            cardSelection.add(
            	words.remove(iRandom)
            );
        }
        return cardSelection;
    }
    
    public void storeProposal() {

        if (proposedWord == NULL) return;

        System.debug('save + ' + proposedWord);
        Word__c word = new Word__c(
        
            Name = proposedWord
        );
            
        insert word;
        
        this.proposedWord = '';
    }
    
    public PageReference refresh() {

        PageReference pr = Page.Bingo;
        pr.setRedirect(true);
        return pr;
    }

    
}